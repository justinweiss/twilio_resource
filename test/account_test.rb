require 'test_helper'
require 'twilio_mock'

class TwilioResource::AccountTest < Test::Unit::TestCase

  def setup
    super
    TwilioMock.setup_remote_fixtures
  end
  
  def test_find_account
    TwilioResource::Base.user = 1
    account = TwilioResource::Account.find(1)
    assert_equal "2", account.status
  end

end
