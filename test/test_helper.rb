require 'test/unit'
require 'rubygems'
require 'reactive_resource'
require 'twilio_resource'

TwilioResource.setup('1', '1')
TwilioResource.logger.level = Logger::WARN
