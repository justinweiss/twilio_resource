require 'test_helper'
require 'twilio_mock'

class TwilioResource::OutgoingCallerIdTest < Test::Unit::TestCase

  def setup
    super
    TwilioMock.setup_remote_fixtures
  end

  def test_find_all
    caller_ids = TwilioResource::OutgoingCallerId.find(:all, :params => {:account_id => 1})
    assert_equal 1, caller_ids.length
    
    # check attributes were assigned correctly
    caller_id = caller_ids.first
    assert_equal('+15105555555', caller_id.phone_number)
  end

  def test_find_by_phone_number
    caller_ids = TwilioResource::OutgoingCallerId.find(:all, :params => {:account_id => 1, :friendly_name => "Foo"})
    assert_equal 1, caller_ids.length
    
    # check attributes were assigned correctly
    caller_id = caller_ids.first
    assert_equal('+15105555555', caller_id.phone_number)
  end

end
