# Encapsulates the changes that need to be made to active_resource's
# defaults in order to communicate with Twilio.
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
