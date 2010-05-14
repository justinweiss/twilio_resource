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
  end

  # what the hell, twilio? who uses capitalization to distinguish
  # between param types? you, that's who.
  def test_find_by_status
    calls = TwilioResource::Call.find(:all, :params => {:account_id => 1, :Status => TwilioResource::Call::COMPLETE})
    assert_equal TwilioResource::Call::COMPLETE, calls.first.status
  end

  def test_find_by_start_time
    calls = TwilioResource::Call.find(:all, :params => {:account_id => 1, :StartTime => '2009-09-01'})
    assert_equal 1, calls.length
  end

  def test_no_results
    calls = TwilioResource::Call.find(:all, :params => {:account_id => 1, :Status => TwilioResource::Call::COMPLETE, :StartTime => '2009-09-01'})
    assert_equal 0, calls.length
  end

end
