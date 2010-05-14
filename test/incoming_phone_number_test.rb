require 'test_helper'
require 'twilio_mock'

class TwilioResource::IncomingPhoneNumberTest < Test::Unit::TestCase

  def setup
    super
    TwilioMock.setup_remote_fixtures
  end

  def test_find
    local_number = TwilioResource::IncomingPhoneNumber.find(1, :params => {:account_id => 1})
    assert_equal '4158675309', local_number.phone_number
  end

  def test_delete_from_class
    assert TwilioResource::IncomingPhoneNumber.delete(1, :account_id => 1)
  end
  
end
