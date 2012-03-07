require 'reactive_resource'

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
class TwilioResource::Base < ReactiveResource::Base

  class << self
    attr_accessor :sid
    attr_accessor :token

    alias_method :user, :sid
    alias_method :user=, :sid=
    alias_method :password, :token
    alias_method :password=, :token=
  end
  
  # Add logging to these requests
  def self.element_path(id, prefix_options = {}, query_options = nil)
    path = super(id, prefix_options, query_options)
    TwilioResource.logger.info("Request: #{path}")
    path
  end

  # Add logging to these requests
  def self.collection_path(prefix_options = {}, query_options = nil)
    path = super(prefix_options, query_options)
    TwilioResource.logger.info("Request: #{path}")
    path
  end

  # Add logging to these requests
  def self.custom_method_collection_url(method_name, options = {})
    path = super(method_name, options)
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
  self.prefix = '/2010-04-01/'
  self.format = :twilio
end
