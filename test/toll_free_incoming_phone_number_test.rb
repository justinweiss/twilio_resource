require 'test_helper'
require 'twilio_mock'

class TwilioResource::TollFreeIncomingPhoneNumberTest < Test::Unit::TestCase

  def setup
    super
    TwilioMock.setup_remote_fixtures
  end
  
  def test_provision_toll_free_number
    TwilioResource::Base.user = 1
    phone = TwilioResource::TollFreeIncomingPhoneNumber.new(:url => "http://example.com/calls",
                                                    :method => 'POST',
                                                    :friendly_name => "My Local Number",
                                                    :account_id => TwilioResource::Base.user)
    assert_equal "FriendlyName=My+Local+Number&Method=POST&Url=http%3A%2F%2Fexample.com%2Fcalls", phone.encode
    phone.save

    assert_equal '8774567890', phone.phone_number
  end

  # test find, update

end
