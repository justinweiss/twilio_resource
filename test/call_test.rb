require 'test_helper'
require 'twilio_mock'

class TwilioResource::CallTest < Test::Unit::TestCase

  def setup
    super
    TwilioMock.setup_remote_fixtures
  end

  def test_find_all
    calls = TwilioResource::Call.find(:all, :params => {:account_id => 1})
    assert_equal 2, calls.length
    
    # check attributes were assigned correctly
    call = calls.first
    assert_equal('4159633717', call.called)
    assert_equal('4156767925', call.caller)
    assert(call.call_segment_sid.blank?)
  end

  # what the hell, twilio? who uses capitalization to distinguish
  # between param types? you, that's who.
  def test_find_by_status
    calls = TwilioResource::Call.find(:all, :params => {:account_id => 1, :status => TwilioResource::Call::COMPLETE})
    assert_equal TwilioResource::Call::COMPLETE, calls.first.status
  end

  def test_find_by_start_time
    calls = TwilioResource::Call.find(:all, :params => {:account_id => 1, :start_time => '2009-09-01'})
    assert_equal 1, calls.length
  end

  def test_no_results
    calls = TwilioResource::Call.find(:all, :params => {:account_id => 1, :status => TwilioResource::Call::COMPLETE, :start_time => '2009-09-01'})
    assert_equal 0, calls.length
  end

end
