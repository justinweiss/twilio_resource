require 'test_helper'
require 'twilio_mock'

class TwilioResource::LocalIncomingPhoneNumberTest < Test::Unit::TestCase

  def setup
    super
    TwilioMock.setup_remote_fixtures
  end
  
  def test_provision_local_number
    phone = TwilioResource::LocalIncomingPhoneNumber.new(:url => "http://example.com/calls",
                                                 :area_code => "206",
                                                 :method => 'POST',
                                                 :friendly_name => "My Local Number",
                                                 :account_id => 1)
    assert_equal "AreaCode=206&FriendlyName=My+Local+Number&Method=POST&Url=http%3A%2F%2Fexample.com%2Fcalls", phone.encode
    phone.save

    assert_equal '2064567890', phone.phone_number
  end

  def test_save_with_unavailable_number_throws_exception
    TwilioResource::Base.user = 2
    phone = TwilioResource::LocalIncomingPhoneNumber.new(:url => "http://example.com/calls",
                                                 :area_code => "815",
                                                 :method => 'POST',
                                                 :friendly_name => "My Local Number",
                                                 :account_id => TwilioResource::Base.user)
    assert_equal "AreaCode=815&FriendlyName=My+Local+Number&Method=POST&Url=http%3A%2F%2Fexample.com%2Fcalls", phone.encode
    assert_raises TwilioResource::NoPhoneNumbersFoundException do 
      phone.save
    end

  end

  # test find, update

end
