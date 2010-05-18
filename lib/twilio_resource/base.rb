# Encapsulates the changes that need to be made to active_resource's
# defaults in order to communicate with Twilio. There are a few main
# issues with ActiveResource's defaults:
#
# 1. Twilio's urls don't take an extension. ActiveResource requires
#    endpoints to have an extension corresponding to the type of data,
#    for example: +resource.xml+ or +resource.json+. Twilio's are
#    always xml, but have no extension.
# 
# 2. Twilio uses capitalized names in their URLs. For instance,
#    instead of '/account/1/calls/1', they use '/Account/1/Calls/1'.
# 
# 3. Twilio takes form encoded params, like token=blah&sid=foo, but
#    returns data in XML. These changes are encapsulated in
#    ActiveResource::Formats::TwilioFormat.
# 
# All of the Twilio ActiveResource classes inherit from this class.
class TwilioResource::Base < ActiveResource::Base

  class << self
    attr_accessor :sid
    attr_accessor :token

    alias_method :user, :sid
    alias_method :user=, :sid=
    alias_method :password, :token
    alias_method :password=, :token=
  end
  
  # Have to override this to make empty extensions work (without the dot)
  def self.element_path(id, prefix_options = {}, query_options = nil)
    prefix_options, query_options = split_options(prefix_options) if query_options.nil?
    extension = format.extension.blank? ? "" : ".#{format.extension}"
    path = "#{prefix(prefix_options)}#{collection_name}/#{id}#{extension}#{query_string(query_options)}"
    TwilioResource.logger.info("Request: #{path}")
    path
  end

  # Have to override this to make empty extensions work (without the dot)
  def self.collection_path(prefix_options = {}, query_options = nil)
    prefix_options, query_options = split_options(prefix_options) if query_options.nil?
    extension = format.extension.blank? ? "" : ".#{format.extension}"
    path = "#{prefix(prefix_options)}#{collection_name}#{extension}#{query_string(query_options)}"
    TwilioResource.logger.info("Request: #{path}")
    path
  end

  # Have to override this to make empty extensions work (without the dot)
  def self.custom_method_collection_url(method_name, options = {})
    prefix_options, query_options = split_options(options)
    extension = format.extension.blank? ? "" : ".#{format.extension}"
    path = "#{prefix(prefix_options)}#{collection_name}/#{method_name}#{extension}#{query_string(query_options)}"
    TwilioResource.logger.info("Request: #{path}")
    path
  end

  # Twilio uses capitalized path names
  def self.element_name
    super.camelize
  end

  def self.query_string(params)
    # camelize all the param keys, because that's what Twilio expects
    fixed_params_list = params.map {|k, v| [k.to_s.camelize, v]}.flatten
    fixed_params_hash = Hash[*fixed_params_list] # Hash really needs a decent #map
    super(fixed_params_hash)
  end

  # we should wrap the exceptions we can
  def save(*params)
    begin
      super(*params)
    rescue => e
      raise TwilioResource::Exception.find_exception(e)
    end

  end


  self.site = "https://api.twilio.com"
  self.prefix = '/2008-08-01/'
  self.format = :twilio
end
