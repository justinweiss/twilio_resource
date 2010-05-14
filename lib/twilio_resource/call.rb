class TwilioResource::Call < TwilioResource::Base
  self.prefix = superclass.prefix_source + 'Accounts/:account_id/'

  NOT_DIALED = 0
  IN_PROGRESS = 1
  COMPLETE = 2

  def status
    attributes["status"].to_i if attributes["status"]
  end
 
end
