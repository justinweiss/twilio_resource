
# Encapsulates a Twilio call resource. Documentation:
# - http://www.twilio.com/docs/api/2008-08-01/rest/call
# - http://www.twilio.com/docs/api/2008-08-01/rest/making_calls
class TwilioResource::Call < TwilioResource::Base
  self.prefix = superclass.prefix_source + 'Accounts/:account_id/'

  NOT_DIALED = 0
  IN_PROGRESS = 1
  COMPLETE = 2

  # Returns the status of the call. Can be
  # TwilioResource::Call::NOT_DIALED,
  # TwilioResource::Call::IN_PROGRESS, or
  # TwilioResource::Call::COMPLETE
  def status
    attributes["status"].to_i if attributes["status"]
  end
 
end
