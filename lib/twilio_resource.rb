require 'logger'
require 'reactive_resource'

require 'twilio_resource/twilio_format'
require 'twilio_resource/exceptions'

module TwilioResource

  autoload :Base, 'twilio_resource/base'
  autoload :Account, 'twilio_resource/account'
  autoload :Call, 'twilio_resource/call'
  autoload :IncomingPhoneNumber, 'twilio_resource/incoming_phone_number'
  autoload :LocalIncomingPhoneNumber, 'twilio_resource/local_incoming_phone_number'
  autoload :TollFreeIncomingPhoneNumber, 'twilio_resource/toll_free_incoming_phone_number'
  autoload :OutgoingCallerId, 'twilio_resource/outgoing_caller_id'
  
  class << self
    attr_accessor :logger
  end

  # Sets up the credentials the ActiveResources will use to access the
  # twilio API. Optionally takes a +logger+, which defaults to +STDOUT+.
  def self.setup(sid, token, logger = nil)
    @logger = logger || Logger.new(STDOUT) 
    TwilioResource::Base.sid = sid
    TwilioResource::Base.token = token
  end
end
