require 'active_resource/http_mock'

class TwilioMock
  
  def self.setup_remote_fixtures
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/2008-08-01/Accounts/1', auth_get(1), main_account
      mock.post '/2008-08-01/Accounts/1/IncomingPhoneNumbers/Local', auth_post(1), local_number_provision_success
      mock.post '/2008-08-01/Accounts/2/IncomingPhoneNumbers/Local', auth_post(2), no_local_number, 400
      mock.post '/2008-08-01/Accounts/1/IncomingPhoneNumbers/TollFree', auth_post(1), toll_free_number_provision_success

      mock.get '/2008-08-01/Accounts/1/Calls', auth_get(1), all_calls
      mock.get '/2008-08-01/Accounts/1/Calls?StartTime=2009-09-01', auth_get(1), recent_calls      
      mock.get '/2008-08-01/Accounts/1/Calls?Status=2', auth_get(1), succeeded_recent_calls
      mock.get '/2008-08-01/Accounts/1/Calls?StartTime=2009-09-01&Status=2', auth_get(1), no_calls

      mock.get '/2008-08-01/Accounts/1/IncomingPhoneNumbers/1', auth_get(1), phone_number_data
      mock.delete '/2008-08-01/Accounts/1/IncomingPhoneNumbers/1', auth_delete(1), phone_number_delete_success
      mock.delete '/2008-08-01/Accounts/2/IncomingPhoneNumbers/2', auth_delete(2), "", 404

    end

  end

  def self.build_header(method)
    if ActiveResource::VERSION::MAJOR == 3
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
        <Url>http://mycompany.com/handleMainLineCall.asp</Url>
        <Method>GET</Method>
        <DateCreated>Tue, 01 Apr 2008 11:26:32 -0700</DateCreated> 
        <DateUpdated>Tue, 01 Apr 2008 11:26:32 -0700</DateUpdated> 
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
        <Status>2</Status>
        <StatusText>Active</StatusText>  
        <DateCreated>Wed, 02 Apr 2008 17:33:38 -0700</DateCreated>
        <DateUpdated>Wed, 02 Apr 2008 17:34:18 -0700</DateUpdated>  
        <AuthToken>3a2630a909aadbf60266234756fb15a0</AuthToken>  
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
            <DateCreated>Sat, 07 Feb 2009 13:15:19 -0800</DateCreated>
            <DateUpdated>Sat, 07 Feb 2009 13:15:19 -0800</DateUpdated>
            <CallSegmentSid/>  
            <AccountSid>AC309475e5fede1b49e100272a8640f438</AccountSid>  
            <Called>4159633717</Called>  
            <Caller>4156767925</Caller>  
            <PhoneNumberSid>PN01234567890123456789012345678900</PhoneNumberSid>  
            <Status>2</Status>  
            <StartTime>Thu, 03 Apr 2008 04:36:33 -0400</StartTime>  
            <EndTime>Thu, 03 Apr 2008 04:36:47 -0400</EndTime>  
            <Duration>14</Duration>  
            <Price/>  
            <Flags>1</Flags>  
        </Call>  
        <Call>  
            <Sid>CA751e8fa0a0105cf26a0d7a9775fb4bfb</Sid>  
            <DateCreated>Sat, 07 Feb 2009 13:15:19 -0800</DateCreated>
            <DateUpdated>Sat, 07 Feb 2009 13:15:19 -0800</DateUpdated>
            <CallSegmentSid/>  
            <AccountSid>AC309475e5fede1b49e100272a8640f438</AccountSid>  
            <Called>2064287985</Called>  
            <Caller>4156767925</Caller>  
            <PhoneNumberSid>PNd59c2ba27ef48264773edb90476d1674</PhoneNumberSid>  
            <Status>2</Status>  
            <StartTime>Thu, 03 Apr 2008 01:37:05 -0400</StartTime>  
            <EndTime>Thu, 03 Apr 2008 01:37:40 -0400</EndTime>  
            <Duration>35</Duration>  
            <Price/>  
            <Flags>1</Flags>
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
            <CallSegmentSid/>  
            <AccountSid>AC309475e5fede1b49e100272a8640f438</AccountSid>  
            <Called>4159633717</Called>  
            <Caller>4156767925</Caller>  
            <PhoneNumberSid>PN01234567890123456789012345678900</PhoneNumberSid>  
            <Status>2</Status>  
            <StartTime>Thu, 03 Apr 2008 04:36:33 -0400</StartTime>  
            <EndTime>Thu, 03 Apr 2008 04:36:47 -0400</EndTime>  
            <Duration>14</Duration>  
            <Price/>  
            <Flags>1</Flags>  
        </Call>  
        <Call>  
            <Sid>1000</Sid>  
            <DateCreated>Sat, 07 Feb 2009 13:15:19 -0800</DateCreated>
            <DateUpdated>Sat, 07 Feb 2009 13:15:19 -0800</DateUpdated>
            <CallSegmentSid>10001</CallSegmentSid>  
            <AccountSid>AC309475e5fede1b49e100272a8640f438</AccountSid>  
            <Called>4159633717</Called>  
            <Caller>4156767925</Caller>  
            <PhoneNumberSid>ABC123</PhoneNumberSid>  
            <Status>2</Status>  
            <StartTime>Thu, 03 Apr 2008 04:36:33 -0400</StartTime>  
            <EndTime>Thu, 03 Apr 2008 04:36:47 -0400</EndTime>  
            <Duration>14</Duration>  
            <Price/>  
            <Flags>1</Flags>  
        </Call>
        <Call>  
            <Sid>1001</Sid>  
            <DateCreated>Sat, 07 Feb 2009 13:15:19 -0800</DateCreated>
            <DateUpdated>Sat, 07 Feb 2009 13:15:19 -0800</DateUpdated>
            <CallSegmentSid>10002</CallSegmentSid>  
            <AccountSid>AC309475e5fede1b49e100272a8640f438</AccountSid>  
            <Called>4159633717</Called>  
            <Caller>4156767925</Caller>  
            <PhoneNumberSid>ABC123</PhoneNumberSid>  
            <Status>2</Status>
            <StartTime>Thu, 03 Apr 2008 04:36:33 -0400</StartTime>  
            <EndTime>Thu, 03 Apr 2008 04:36:47 -0400</EndTime>  
            <Duration>14</Duration>  
            <Price/>  
            <Flags>1</Flags>  
        </Call>
        <Call>  
            <Sid>1002</Sid>  
            <DateCreated>Sat, 07 Feb 2009 13:15:19 -0800</DateCreated>
            <DateUpdated>Sat, 07 Feb 2009 13:15:19 -0800</DateUpdated>
            <CallSegmentSid>10003</CallSegmentSid>  
            <AccountSid>AC309475e5fede1b49e100272a8640f438</AccountSid>  
            <Called>4159633717</Called>  
            <Caller>4156767925</Caller>  
            <PhoneNumberSid>ABC123</PhoneNumberSid>  
            <Status>2</Status>
            <StartTime>Thu, 03 Apr 2008 04:36:33 -0400</StartTime>  
            <EndTime>Thu, 03 Apr 2008 04:36:47 -0400</EndTime>  
            <Duration>14</Duration>  
            <Price/>  
            <Flags>1</Flags>  
        </Call>
        <Call>  
            <Sid>1003</Sid>  
            <DateCreated>Sat, 07 Feb 2009 13:15:19 -0800</DateCreated>
            <DateUpdated>Sat, 07 Feb 2009 13:15:19 -0800</DateUpdated>
            <CallSegmentSid>10004</CallSegmentSid>  
            <AccountSid>AC309475e5fede1b49e100272a8640f438</AccountSid>  
            <Called>4159633717</Called>  
            <Caller>4156767925</Caller>  
            <PhoneNumberSid>UNKNOWN</PhoneNumberSid>  
            <Status>2</Status>
            <StartTime>Thu, 03 Apr 2008 04:36:33 -0400</StartTime>  
            <EndTime>Thu, 03 Apr 2008 04:36:47 -0400</EndTime>  
            <Duration>14</Duration>  
            <Price/>  
            <Flags>1</Flags>  
        </Call>
        <Call>  
            <Sid>AVENDORIDAVENDORIDAVENDORID</Sid>  
            <DateCreated>Sat, 07 Feb 2009 13:15:19 -0800</DateCreated>
            <DateUpdated>Sat, 07 Feb 2009 13:15:19 -0800</DateUpdated>
            <CallSegmentSid>10004</CallSegmentSid>  
            <AccountSid>AC309475e5fede1b49e100272a8640f438</AccountSid>  
            <Called>4159633717</Called>  
            <Caller>4156767925</Caller>  
            <PhoneNumberSid>ABC123</PhoneNumberSid>  
            <Status>2</Status>
            <StartTime>Thu, 03 Apr 2008 04:36:33 -0400</StartTime>  
            <EndTime>Thu, 03 Apr 2008 04:36:47 -0400</EndTime>  
            <Duration>14</Duration>  
            <Price/>  
            <Flags>1</Flags>  
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
            <CallSegmentSid/>  
            <AccountSid>AC309475e5fede1b49e100272a8640f438</AccountSid>  
            <Called>4159633717</Called>  
            <Caller>4156767925</Caller>  
            <PhoneNumberSid>PN01234567890123456789012345678900</PhoneNumberSid>  
            <Status>1</Status>  
            <StartTime>Thu, 03 Apr 2008 04:36:33 -0400</StartTime>  
            <EndTime>Thu, 03 Apr 2008 04:36:47 -0400</EndTime>  
            <Duration>14</Duration>  
            <Price/>  
            <Flags>1</Flags>  
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
            <CallSegmentSid>8142ed11f93dc08b952027ffbc406d0868</CallSegmentSid>  
            <AccountSid>AC309475e5fede1b49e100272a8640f438</AccountSid>  
            <Called>4159633717</Called>  
            <Caller>4156767925</Caller>  
            <PhoneNumberSid>PN01234567890123456789012345678900</PhoneNumberSid>  
            <Status>2</Status>  
            <StartTime>Thu, 03 Apr 2008 04:36:33 -0400</StartTime>  
            <EndTime>Thu, 03 Apr 2008 04:36:47 -0400</EndTime>  
            <Duration>14</Duration>  
            <Price/>  
            <Flags>1</Flags>  
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
        <AccountSid>AC35542fc30a091bed0c1ed511e1d9935d</AccountSid> 
        <FriendlyName>My Local Number</FriendlyName> 
        <PhoneNumber>2064567890</PhoneNumber> 
        <Url>http://example.com/calls</Url>
        <Method>GET</Method>
        <DateCreated>Tue, 01 Apr 2008 11:26:32 -0700</DateCreated> 
        <DateUpdated>Tue, 01 Apr 2008 11:26:32 -0700</DateUpdated> 
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
        <Url>http://example.com/calls</Url>
        <Method>GET</Method>
        <DateCreated>Tue, 01 Apr 2008 11:26:32 -0700</DateCreated> 
        <DateUpdated>Tue, 01 Apr 2008 11:26:32 -0700</DateUpdated> 
    </IncomingPhoneNumber> 
</TwilioResponse>   
END
  end

  def self.no_local_number
<<END
<TwilioResponse><RestException><Status>400</Status><Message>No phone numbers found</Message><Code>21452</Code><MoreInfo>http://www.twilio.com/docs/errors/21452</MoreInfo></RestException></TwilioResponse>
END
  end

end
