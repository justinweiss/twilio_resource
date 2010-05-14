require 'test/unit'
require 'rubygems'
require 'activeresource'
require 'twilio_resource'

TwilioResource.setup('1', '1')
TwilioResource.logger.level = Logger::WARN
