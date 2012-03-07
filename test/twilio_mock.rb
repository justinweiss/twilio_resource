require 'active_resource/http_mock'

class TwilioMock

  def self.setup_remote_fixtures
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/2010-04-01/Accounts/1', auth_get(1), main_account
      mock.post '/2010-04-01/Accounts/1/IncomingPhoneNumbers/Local', auth_post(1), local_number_provision_success
      mock.post '/2010-04-01/Accounts/2/IncomingPhoneNumbers/Local', auth_post(2), no_local_number, 400
      mock.post '/2010-04-01/Accounts/1/IncomingPhoneNumbers/TollFree', auth_post(1), toll_free_number_provision_success

      mock.get '/2010-04-01/Accounts/1/Calls', auth_get(1), all_calls
      mock.get '/2010-04-01/Accounts/1/Calls?StartTime=2009-09-01', auth_get(1), recent_calls
      mock.get '/2010-04-01/Accounts/1/Calls?Status=completed', auth_get(1), succeeded_recent_calls
      mock.get '/2010-04-01/Accounts/1/Calls?StartTime=2009-09-01&Status=completed', auth_get(1), no_calls

      mock.get '/2010-04-01/Accounts/1/IncomingPhoneNumbers/1', auth_get(1), phone_number_data
      mock.delete '/2010-04-01/Accounts/1/IncomingPhoneNumbers/1', auth_delete(1), phone_number_delete_success
      mock.delete '/2010-04-01/Accounts/2/IncomingPhoneNumbers/2', auth_delete(2), "", 404

      mock.get '/2010-04-01/Accounts/1/OutgoingCallerIds', auth_get(1), all_caller_ids
      mock.get '/2010-04-01/Accounts/1/OutgoingCallerIds?FriendlyName=Foo', auth_get(1), friendly_name_caller_ids
    end

  end

  def self.build_header(method)
    if defined?(ActiveResource::VERSION) && ActiveResource::VERSION::MAJOR == 3
      TwilioResource::Account.connection.send(:build_request_headers, {}, method, '')
    else
      TwilioResource::Account.connection.send(:build_request_headers, {})
    end
  end

  def self.auth_delete(account_id)
    old_account_id = TwilioResource::Base.user
    TwilioResource::Base.user = account_id
    auth = build_header(:delete)
    TwilioResource::Base.user = old_account_id
    auth
  end

  def self.auth_post(account_id)
    old_account_id = TwilioResource::Base.user
    TwilioResource::Base.user = account_id
    auth = build_header(:post)
    TwilioResource::Base.user = old_account_id
    auth
  end

  def self.auth_get(account_id)
    old_account_id = TwilioResource::Base.user
    TwilioResource::Base.user = account_id
    auth = build_header(:get)
    TwilioResource::Base.user = old_account_id
    auth
  end

  def self.phone_number_data
<<END
<TwilioResponse>
    <IncomingPhoneNumber>
        <Sid>PNe536dfda7c6184afab78d980cb8cdf43</Sid>
        <AccountSid>AC35542fc30a091bed0c1ed511e1d9935d</AccountSid>
        <FriendlyName>My Home Phone Number</FriendlyName>
        <PhoneNumber>4158675309</PhoneNumber>
        <VoiceUrl>http://mycompany.com/handleNewCall.php</VoiceUrl>
        <VoiceMethod>POST</VoiceMethod>
        <VoiceFallbackUrl/>
        <VoiceFallbackMethod>POST</VoiceFallbackMethod>
        <StatusCallback/>
        <StatusCallbackMethod/>
        <VoiceCallerIdLookup>false</VoiceCallerIdLookup>
        <VoiceApplicationSid/>
        <DateCreated>Mon, 16 Aug 2010 23:00:23 +0000</DateCreated>
        <DateUpdated>Mon, 16 Aug 2010 23:00:23 +0000</DateUpdated>
        <SmsUrl/>
        <SmsMethod>POST</SmsMethod>
        <SmsFallbackUrl/>
        <SmsFallbackMethod>GET</SmsFallbackMethod>
        <SmsApplicationSid>AP9b2e38d8c592488c397fc871a82a74ec</SmsApplicationSid>
        <Capabilities>
            <Voice>true</Voice>
            <SMS>true</SMS>
        </Capabilities>
        <ApiVersion>2010-04-01</ApiVersion>
        <Uri>/2010-04-01/Accounts/ACdc5f1e11047ebd6fe7a55f120be3a900/IncomingPhoneNumbers/PN2a0747eba6abf96b7e3c3ff0b4530f6e</Uri>
    </IncomingPhoneNumber>
</TwilioResponse>
END
  end

  def self.main_account
<<END
<TwilioResponse>
  <Account>
    <Sid>AC309475e5fede1b49e100272a8640f438</Sid>
    <FriendlyName>My Twilio Account</FriendlyName>
    <Type>Full</Type>
    <Status>active</Status>
    <DateCreated>Wed, 04 Aug 2010 21:37:41 +0000</DateCreated>
    <DateUpdated>Fri, 06 Aug 2010 01:15:02 +0000</DateUpdated>
    <AuthToken>redacted</AuthToken>
    <Uri>/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d</Uri>
    <SubresourceUris>
      <AvailablePhoneNumbers>/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/AvailablePhoneNumbers</AvailablePhoneNumbers>
      <Calls>/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Calls</Calls>
      <Conferences>/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Conferences</Conferences>
      <IncomingPhoneNumbers>/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/IncomingPhoneNumbers</IncomingPhoneNumbers>
      <Notifications>/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Notifications</Notifications>
      <OutgoingCallerIds>/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/OutgoingCallerIds</OutgoingCallerIds>
      <Recordings>/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Recordings</Recordings>
      <Sandbox>/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Sandbox</Sandbox>
      <SMSMessages>/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/SMS/Messages</SMSMessages>
      <Transcriptions>/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Transcriptions</Transcriptions>
    </SubresourceUris>
  </Account>
</TwilioResponse>
END
  end

  def self.phone_number_delete_success
<<END
 <TwilioResponse />
END
  end

  def self.all_calls
<<END
<TwilioResponse>
    <Calls page="0" numpages="1" pagesize="50" total="38" start="0" end="37">
        <Call>
            <Sid>CA42ed11f93dc08b952027ffbc406d0868</Sid>
            <DateCreated>Fri, 13 Aug 2010 01:16:22 +0000</DateCreated>
            <DateUpdated>Fri, 13 Aug 2010 01:16:22 +0000</DateUpdated>
            <ParentCallSid/>
            <AccountSid>AC5ef877a5fe4238be081ea6f3c44186f3</AccountSid>
            <To>+15304551166</To>
            <From>+15105555555</From>
            <PhoneNumberSid>PNe2d8e63b37f46f2adb16f228afdb9058</PhoneNumberSid>
            <Status>queued</Status>
            <StartTime>Thu, 12 Aug 2010 01:37:05 +0000</StartTime>
            <EndTime>Thu, 12 Aug 2010 01:37:40 +0000</EndTime>
            <Duration/>
            <Price/>
            <Direction>outbound-api</Direction>
            <AnsweredBy/>
            <ApiVersion>2010-04-01</ApiVersion>
            <ForwardedFrom/>
            <CallerName/>
            <Uri>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c</Uri>
            <SubresourceUris>
                <Notifications>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Notifications</Notifications>
                <Recordings>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Recordings</Recordings>
            </SubresourceUris>
        </Call>
        <Call>
            <Sid>CA751e8fa0a0105cf26a0d7a9775fb4bfb</Sid>
            <DateCreated>Fri, 13 Aug 2010 01:16:22 +0000</DateCreated>
            <DateUpdated>Fri, 13 Aug 2010 01:16:22 +0000</DateUpdated>
            <ParentCallSid/>
            <AccountSid>AC5ef877a5fe4238be081ea6f3c44186f3</AccountSid>
            <To>+15304551166</To>
            <From>+15105555555</From>
            <PhoneNumberSid>PNe2d8e63b37f46f2adb16f228afdb9058</PhoneNumberSid>
            <Status>queued</Status>
            <StartTime>Thu, 12 Aug 2010 01:37:05 +0000</StartTime>
            <EndTime>Thu, 12 Aug 2010 01:37:40 +0000</EndTime>
            <Duration/>
            <Price/>
            <Direction>outbound-api</Direction>
            <AnsweredBy/>
            <ApiVersion>2010-04-01</ApiVersion>
            <ForwardedFrom/>
            <CallerName/>
            <Uri>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c</Uri>
            <SubresourceUris>
                <Notifications>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Notifications</Notifications>
                <Recordings>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Recordings</Recordings>
            </SubresourceUris>
        </Call>
    </Calls>
</TwilioResponse>
END
  end

  def self.succeeded_calls
<<END
<TwilioResponse>
    <Calls page="0" numpages="1" pagesize="50" total="38" start="0" end="37">
        <Call>
            <Sid>CA42ed11f93dc08b952027ffbc406d0868</Sid>
            <DateCreated>Sat, 07 Feb 2009 13:15:19 -0800</DateCreated>
            <DateUpdated>Sat, 07 Feb 2009 13:15:19 -0800</DateUpdated>
            <ParentCallSid/>
            <AccountSid>AC5ef877a5fe4238be081ea6f3c44186f3</AccountSid>
            <To>+15304551166</To>
            <From>+15105555555</From>
            <PhoneNumberSid>PNe2d8e63b37f46f2adb16f228afdb9058</PhoneNumberSid>
            <Status>completed</Status>
            <StartTime>Thu, 12 Aug 2010 01:37:05 +0000</StartTime>
            <EndTime>Thu, 12 Aug 2010 01:37:40 +0000</EndTime>
            <Duration>14</Duration>
            <Price/>
            <Direction>outbound-api</Direction>
            <AnsweredBy/>
            <ApiVersion>2010-04-01</ApiVersion>
            <ForwardedFrom/>
            <CallerName/>
            <Uri>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c</Uri>
            <SubresourceUris>
                <Notifications>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Notifications</Notifications>
                <Recordings>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Recordings</Recordings>
            </SubresourceUris>
        </Call>
        <Call>
            <Sid>1000</Sid>
            <DateCreated>Sat, 07 Feb 2009 13:15:19 -0800</DateCreated>
            <DateUpdated>Sat, 07 Feb 2009 13:15:19 -0800</DateUpdated>
            <ParentCallSid/>
            <AccountSid>AC5ef877a5fe4238be081ea6f3c44186f3</AccountSid>
            <To>+15304551166</To>
            <From>+15105555555</From>
            <PhoneNumberSid>PNe2d8e63b37f46f2adb16f228afdb9058</PhoneNumberSid>
            <Status>completed</Status>
            <StartTime>Thu, 12 Aug 2010 01:37:05 +0000</StartTime>
            <EndTime>Thu, 12 Aug 2010 01:37:40 +0000</EndTime>
            <Duration>14</Duration>
            <Price/>
            <Direction>outbound-api</Direction>
            <AnsweredBy/>
            <ApiVersion>2010-04-01</ApiVersion>
            <ForwardedFrom/>
            <CallerName/>
            <Uri>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c</Uri>
            <SubresourceUris>
                <Notifications>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Notifications</Notifications>
                <Recordings>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Recordings</Recordings>
            </SubresourceUris>
        </Call>
        <Call>
            <Sid>1001</Sid>
            <DateCreated>Sat, 07 Feb 2009 13:15:19 -0800</DateCreated>
            <DateUpdated>Sat, 07 Feb 2009 13:15:19 -0800</DateUpdated>
            <ParentCallSid/>
            <AccountSid>AC5ef877a5fe4238be081ea6f3c44186f3</AccountSid>
            <To>+15304551166</To>
            <From>+15105555555</From>
            <PhoneNumberSid>PNe2d8e63b37f46f2adb16f228afdb9058</PhoneNumberSid>
            <Status>completed</Status>
            <StartTime>Thu, 12 Aug 2010 01:37:05 +0000</StartTime>
            <EndTime>Thu, 12 Aug 2010 01:37:40 +0000</EndTime>
            <Duration>14</Duration>
            <Price/>
            <Direction>outbound-api</Direction>
            <AnsweredBy/>
            <ApiVersion>2010-04-01</ApiVersion>
            <ForwardedFrom/>
            <CallerName/>
            <Uri>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c</Uri>
            <SubresourceUris>
                <Notifications>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Notifications</Notifications>
                <Recordings>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Recordings</Recordings>
            </SubresourceUris>
        </Call>
        <Call>
            <Sid>1002</Sid>
            <DateCreated>Sat, 07 Feb 2009 13:15:19 -0800</DateCreated>
            <DateUpdated>Sat, 07 Feb 2009 13:15:19 -0800</DateUpdated>
            <ParentCallSid/>
            <AccountSid>AC5ef877a5fe4238be081ea6f3c44186f3</AccountSid>
            <To>+15304551166</To>
            <From>+15105555555</From>
            <PhoneNumberSid>PNe2d8e63b37f46f2adb16f228afdb9058</PhoneNumberSid>
            <Status>completed</Status>
            <StartTime>Thu, 12 Aug 2010 01:37:05 +0000</StartTime>
            <EndTime>Thu, 12 Aug 2010 01:37:40 +0000</EndTime>
            <Duration>14</Duration>
            <Price/>
            <Direction>outbound-api</Direction>
            <AnsweredBy/>
            <ApiVersion>2010-04-01</ApiVersion>
            <ForwardedFrom/>
            <CallerName/>
            <Uri>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c</Uri>
            <SubresourceUris>
                <Notifications>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Notifications</Notifications>
                <Recordings>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Recordings</Recordings>
            </SubresourceUris>
        </Call>
        <Call>
            <Sid>1003</Sid>
            <DateCreated>Sat, 07 Feb 2009 13:15:19 -0800</DateCreated>
            <DateUpdated>Sat, 07 Feb 2009 13:15:19 -0800</DateUpdated>
            <ParentCallSid/>
            <AccountSid>AC5ef877a5fe4238be081ea6f3c44186f3</AccountSid>
            <To>+15304551166</To>
            <From>+15105555555</From>
            <PhoneNumberSid>PNe2d8e63b37f46f2adb16f228afdb9058</PhoneNumberSid>
            <Status>completed</Status>
            <StartTime>Thu, 12 Aug 2010 01:37:05 +0000</StartTime>
            <EndTime>Thu, 12 Aug 2010 01:37:40 +0000</EndTime>
            <Duration>14</Duration>
            <Price/>
            <Direction>outbound-api</Direction>
            <AnsweredBy/>
            <ApiVersion>2010-04-01</ApiVersion>
            <ForwardedFrom/>
            <CallerName/>
            <Uri>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c</Uri>
            <SubresourceUris>
                <Notifications>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Notifications</Notifications>
                <Recordings>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Recordings</Recordings>
            </SubresourceUris>
        </Call>
        <Call>
            <Sid>AVENDORIDAVENDORIDAVENDORID</Sid>
            <DateCreated>Sat, 07 Feb 2009 13:15:19 -0800</DateCreated>
            <DateUpdated>Sat, 07 Feb 2009 13:15:19 -0800</DateUpdated>
            <ParentCallSid/>
            <AccountSid>AC5ef877a5fe4238be081ea6f3c44186f3</AccountSid>
            <To>+15304551166</To>
            <From>+15105555555</From>
            <PhoneNumberSid>PNe2d8e63b37f46f2adb16f228afdb9058</PhoneNumberSid>
            <Status>completed</Status>
            <StartTime>Thu, 12 Aug 2010 01:37:05 +0000</StartTime>
            <EndTime>Thu, 12 Aug 2010 01:37:40 +0000</EndTime>
            <Duration>14</Duration>
            <Price/>
            <Direction>outbound-api</Direction>
            <AnsweredBy/>
            <ApiVersion>2010-04-01</ApiVersion>
            <ForwardedFrom/>
            <CallerName/>
            <Uri>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c</Uri>
            <SubresourceUris>
                <Notifications>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Notifications</Notifications>
                <Recordings>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Recordings</Recordings>
            </SubresourceUris>
        </Call>
    </Calls>
</TwilioResponse>
END
  end

  def self.recent_calls
    <<END
<TwilioResponse>
    <Calls page="0" numpages="1" pagesize="50" total="38" start="0" end="37">
        <Call>
            <Sid>CA42ed11f93dc08b952027ffbc406d0868</Sid>
            <DateCreated>Sat, 07 Feb 2009 13:15:19 -0800</DateCreated>
            <DateUpdated>Sat, 07 Feb 2009 13:15:19 -0800</DateUpdated>
            <ParentCallSid/>
            <AccountSid>AC5ef877a5fe4238be081ea6f3c44186f3</AccountSid>
            <To>+15304551166</To>
            <From>+15105555555</From>
            <PhoneNumberSid>PNe2d8e63b37f46f2adb16f228afdb9058</PhoneNumberSid>
            <Status>completed</Status>
            <StartTime>Thu, 12 Aug 2010 01:37:05 +0000</StartTime>
            <EndTime>Thu, 12 Aug 2010 01:37:40 +0000</EndTime>
            <Duration>14</Duration>
            <Price/>
            <Direction>outbound-api</Direction>
            <AnsweredBy/>
            <ApiVersion>2010-04-01</ApiVersion>
            <ForwardedFrom/>
            <CallerName/>
            <Uri>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c</Uri>
            <SubresourceUris>
                <Notifications>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Notifications</Notifications>
                <Recordings>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Recordings</Recordings>
            </SubresourceUris>
        </Call>
    </Calls>
</TwilioResponse>
END
  end


  def self.succeeded_recent_calls
    <<END
<TwilioResponse>
    <Calls page="0" numpages="1" pagesize="50" total="38" start="0" end="37">
        <Call>
            <Sid>CA42ed11f93dc08b952027ffbc406d0868</Sid>
            <DateCreated>Sat, 07 Feb 2009 13:15:19 -0800</DateCreated>
            <DateUpdated>Sat, 07 Feb 2009 13:15:19 -0800</DateUpdated>
            <ParentCallSid/>
            <AccountSid>AC5ef877a5fe4238be081ea6f3c44186f3</AccountSid>
            <To>+15304551166</To>
            <From>+15105555555</From>
            <PhoneNumberSid>PNe2d8e63b37f46f2adb16f228afdb9058</PhoneNumberSid>
            <Status>completed</Status>
            <StartTime>Thu, 12 Aug 2010 01:37:05 +0000</StartTime>
            <EndTime>Thu, 12 Aug 2010 01:37:40 +0000</EndTime>
            <Duration>14</Duration>
            <Price/>
            <Direction>outbound-api</Direction>
            <AnsweredBy/>
            <ApiVersion>2010-04-01</ApiVersion>
            <ForwardedFrom/>
            <CallerName/>
            <Uri>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c</Uri>
            <SubresourceUris>
                <Notifications>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Notifications</Notifications>
                <Recordings>/2010-04-01/Accounts/AC5ef877a5fe4238be081ea6f3c44186f3/Calls/CA92d4405c9237c4ea04b56cbda88e128c/Recordings</Recordings>
            </SubresourceUris>
        </Call>
    </Calls>
</TwilioResponse>
END
  end

  def self.no_calls
<<END
<TwilioResponse>
    <Calls page="0" numpages="1" pagesize="50" total="38" start="0" end="37">
    </Calls>
</TwilioResponse>
END
  end

  def self.local_number_provision_success
<<END
<TwilioResponse>
    <IncomingPhoneNumber>
        <Sid>PNe536dfda7c6184afab78d980cb8cdf43</Sid>
        <AccountSid>AC755325d45d80675a4727a7a54e1b4ce4</AccountSid>
        <FriendlyName>My Local Number</FriendlyName>
        <PhoneNumber>2064567890</PhoneNumber>
        <VoiceUrl>http://myapp.com/awesome</VoiceUrl>
        <VoiceMethod>POST</VoiceMethod>
        <VoiceFallbackUrl/>
        <VoiceFallbackMethod>POST</VoiceFallbackMethod>
        <VoiceCallerIdLookup>false</VoiceCallerIdLookup>
        <VoiceApplicationSid/>
        <DateCreated>Mon, 16 Aug 2010 23:00:23 +0000</DateCreated>
        <DateUpdated>Mon, 16 Aug 2010 23:00:23 +0000</DateUpdated>
        <SmsUrl>http://myapp.com/awesome</SmsUrl>
        <SmsMethod>POST</SmsMethod>
        <SmsFallbackUrl/>
        <SmsFallbackMethod>GET</SmsFallbackMethod>
        <SmsApplicationSid/>
        <Capabilities>
            <Voice>true</Voice>
            <SMS>true</SMS>
        </Capabilities>
        <StatusCallback/>
        <StatusCallbackMethod/>
        <ApiVersion>2010-04-01</ApiVersion>
        <Uri>/2010-04-01/Accounts/AC755325d45d80675a4727a7a54e1b4ce4/IncomingPhoneNumbers/PN2a0747eba6abf96b7e3c3ff0b4530f6e</Uri>
    </IncomingPhoneNumber>
</TwilioResponse>
END
  end

  def self.toll_free_number_provision_success
<<END
<TwilioResponse>
    <IncomingPhoneNumber>
        <Sid>PNe536dfda7c6184afab78d980cb8cdf43</Sid>
        <AccountSid>AC35542fc30a091bed0c1ed511e1d9935d</AccountSid>
        <FriendlyName>My Toll Free Number</FriendlyName>
        <PhoneNumber>8774567890</PhoneNumber>
        <VoiceUrl>http://myapp.com/awesome</VoiceUrl>
        <VoiceMethod>POST</VoiceMethod>
        <VoiceFallbackUrl/>
        <VoiceFallbackMethod>POST</VoiceFallbackMethod>
        <VoiceCallerIdLookup>false</VoiceCallerIdLookup>
        <VoiceApplicationSid/>
        <DateCreated>Mon, 16 Aug 2010 23:00:23 +0000</DateCreated>
        <DateUpdated>Mon, 16 Aug 2010 23:00:23 +0000</DateUpdated>
        <SmsUrl>http://myapp.com/awesome</SmsUrl>
        <SmsMethod>POST</SmsMethod>
        <SmsFallbackUrl/>
        <SmsFallbackMethod>GET</SmsFallbackMethod>
        <SmsApplicationSid/>
        <Capabilities>
            <Voice>true</Voice>
            <SMS>true</SMS>
        </Capabilities>
        <StatusCallback/>
        <StatusCallbackMethod/>
        <ApiVersion>2010-04-01</ApiVersion>
        <Uri>/2010-04-01/Accounts/AC755325d45d80675a4727a7a54e1b4ce4/IncomingPhoneNumbers/PN2a0747eba6abf96b7e3c3ff0b4530f6e</Uri>
    </IncomingPhoneNumber>
</TwilioResponse>
END
  end

  def self.no_local_number
<<END
<TwilioResponse><RestException><Status>400</Status><Message>No phone numbers found</Message><Code>21452</Code><MoreInfo>http://www.twilio.com/docs/errors/21452</MoreInfo></RestException></TwilioResponse>
END
  end

  def self.all_caller_ids
<<END
<TwilioResponse>
    <OutgoingCallerIds page="0" numpages="1" pagesize="50" total="1" start="0" end="0" uri="/2010-04-01/Accounts/AC228ba7a5fe4238be081ea6f3c44186f3/OutgoingCallerIds" firstpageuri="/2010-04-01/Accounts/AC228ba7a5fe4238be081ea6f3c44186f3/OutgoingCallerIds?Page=0&amp;PageSize=50" previouspageuri="" nextpageuri="" lastpageuri="/2010-04-01/Accounts/AC228ba7a5fe4238be081ea6f3c44186f3/OutgoingCallerIds?Page=0&amp;PageSize=50">
        <OutgoingCallerId>
            <Sid>PNe905d7e6b410746a0fb08c57e5a186f3</Sid>
            <AccountSid>AC228ba7a5fe4238be081ea6f3c44186f3</AccountSid>
            <FriendlyName>Foo</FriendlyName>
            <PhoneNumber>+15105555555</PhoneNumber>
            <DateCreated>Tue, 27 Jul 2010 20:21:11 +0000</DateCreated>
            <DateUpdated>Tue, 27 Jul 2010 20:21:11 +0000</DateUpdated>
            <Uri>/2010-04-01/Accounts/AC228ba7a5fe4238be081ea6f3c44186f3/OutgoingCallerIds/PNe905d7e6b410746a0fb08c57e5a186f3</Uri>
        </OutgoingCallerId>
    </OutgoingCallerIds>
</TwilioResponse>
END
  end

  def self.friendly_name_caller_ids
<<END
<TwilioResponse>
    <OutgoingCallerIds page="0" numpages="1" pagesize="50" total="1" start="0" end="0" uri="/2010-04-01/Accounts/AC228ba7a5fe4238be081ea6f3c44186f3/OutgoingCallerIds" firstpageuri="/2010-04-01/Accounts/AC228ba7a5fe4238be081ea6f3c44186f3/OutgoingCallerIds?Page=0&amp;PageSize=50" previouspageuri="" nextpageuri="" lastpageuri="/2010-04-01/Accounts/AC228ba7a5fe4238be081ea6f3c44186f3/OutgoingCallerIds?Page=0&amp;PageSize=50">
        <OutgoingCallerId>
            <Sid>PNe905d7e6b410746a0fb08c57e5a186f3</Sid>
            <AccountSid>AC228ba7a5fe4238be081ea6f3c44186f3</AccountSid>
            <FriendlyName>Foo</FriendlyName>
            <PhoneNumber>+15105555555</PhoneNumber>
            <DateCreated>Tue, 27 Jul 2010 20:21:11 +0000</DateCreated>
            <DateUpdated>Tue, 27 Jul 2010 20:21:11 +0000</DateUpdated>
            <Uri>/2010-04-01/Accounts/AC228ba7a5fe4238be081ea6f3c44186f3/OutgoingCallerIds/PNe905d7e6b410746a0fb08c57e5a186f3</Uri>
        </OutgoingCallerId>
    </OutgoingCallerIds>
</TwilioResponse>
END
  end

end
