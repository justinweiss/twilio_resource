require 'logger'
require 'activeresource'

require 'twilio_resource/twilio_format'
require 'twilio_resource/exceptions'

module TwilioResource
  
  class << self
    attr_accessor :logger
  end

  def self.setup(sid, token, logger = nil)
    @logger = logger || Logger.new(STDOUT) 
    TwilioResource::Base.sid = sid
    TwilioResource::Base.token = token
  end
end

require 'twilio_resource/base'
require 'twilio_resource/account'
require 'twilio_resource/call'
require 'twilio_resource/incoming_phone_number'
require 'twilio_resource/local_incoming_phone_number'
require 'twilio_resource/toll_free_incoming_phone_number'
