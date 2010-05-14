module ActiveResource
  module Formats
    module TwilioFormat
      extend self
      
      def extension
        ""
      end
      
      def mime_type
        'application/x-www-form-urlencoded'
      end
      
      # twilio uses camelcase for all of its params, and uses a query string for posts.
      def encode(hash, options = {})
        camelized_hash = ActiveSupport::OrderedHash.new
        hash.each do |k, v| 
          camelized_hash[k.camelize] = v
        end

        TwilioResource.logger.info("Request: #{camelized_hash.to_query}")
        camelized_hash.to_query
      end
      
      def decode(xml)
        TwilioResource.logger.debug("Response: #{xml}")
        from_xml_data(Hash.from_xml(xml))
      end
      
      private
      # Manipulate from_xml Hash, because twilio doesn't format their
      # xml in the way active_resource expects it.
      def from_xml_data(data)
        if data.is_a?(Hash) && data['twilio_response']
          from_xml_data(data['twilio_response'])
        else
          data.each do |k, v|
            # convert array-like things to actual arrays. twilio
            # paginates their arrays, so it's easy to detect here.  If
            # it's the empty set, initialize it to an array so
            # active_resource doesn't throw a fit.
            if v["page"]
              array_data = v[k.singularize] 
              data[k] = [array_data].flatten.compact
            elsif v.blank?
              data[k] = []
            end
          end
          # now we have "calls" => [c1, c2, ...], but active_resource
          # expects [c1, c2, c3]
          data.values.first
        end
      end
    end
  end
end
