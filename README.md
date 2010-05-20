Description
-----------

TwilioResource is a wrapper around the [Twilio API](http://www.twilio.com/docs/api/2008-08-01/rest/)
using Rails' ActiveResource. This allows you to treat Twilio objects
as if they're local ActiveRecord models:

    phone = TwilioResource::LocalIncomingPhoneNumber.new(:url => 'http://www.example.com',
                                                         :area_code => '206',
                                                         :method => 'GET',
                                                         :friendly_name => "My First Phone Number",
                                                         :account_id => Twilio::Base.user)
    phone.save


The wrapper doesn't support the entire Twilio API, but it should be
simple enough to add new functionality as needed by following the 
models that are already built.


Supported Functionality
=======================
- Requesting, listing, and deleting new local and toll-free numbers
- Placing and listing calls made to a phone number

Todo
----
- Conference resource
- Redirecting calls
- Support data returned in xml attributes
- SMS resource
- Recordings, Transcriptions, and Notifications
- Wrap more exceptions
- Add documentation on supported attributes to the ActiveResource models

Setup
=====

Before you start using TwilioResource, you have to give it your Twilio
login credentials. You can do this in your Rails initializer:

    require 'twilio_resource'
    TwilioResource.setup('token', 'sid')

Examples
========

Requesting a new phone number:

    phone = TwilioResource::LocalIncomingPhoneNumber.new(:url => 'http://www.example.com',
                                                         :area_code => '206',
                                                         :method => 'GET',
                                                         :friendly_name => "My First Phone Number",
                                                         :account_id => Twilio::Base.user)
    phone.save

Requesting a new toll-free phone number:

    phone = TwilioResource::TollFreeIncomingPhoneNumber.new(:url => 'http://www.example.com',
                                                            :area_code => '206',
                                                            :method => 'GET',
                                                            :friendly_name => "My First Phone Number",
                                                            :account_id => Twilio::Base.user)
    phone.save

Retrieving a list of completed calls to a given phone number:

    TwilioResource::Call.find(:all, :params => {
      :account_id => Twilio::Base.user, 
      :status => Twilio::Call::COMPLETE,
      :called => '2065551212'})

Placing a call:

    TwilioResource::Call.new({
      :account_id => Twilio::Base.user, 
      :caller => '2065551111',
      :called => '2065551212',
      :url => 'http://example.com/call.xml'})