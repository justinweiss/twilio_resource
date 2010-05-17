

Description
-----------

Supported Functionality
-----------------------

- Requesting, listing, and deleting new local and toll-free numbers
- Placing and listing calls made to a number

Todo
====
- Conference resource
- Redirecting calls
- Support data returned in xml attributes
- SMS resource
- Recordings, Transcriptions, and Notifications
- Wrap more exceptions

Setup
-----

Before you start using TwilioResource, you have to give it your Twilio
login credentials. You can do this in your Rails initializer:

    require 'twilio_resource'
    TwilioResource.setup('token', 'sid')

Examples
--------

Requesting a new phone number:

Requesting a new toll-free phone number:

Retrieving a list of calls for a given phone number:

Placing a call: