class TwilioResource::IncomingPhoneNumber < TwilioResource::Base
  self.prefix = superclass.prefix_source + 'Accounts/:account_id/'
end
