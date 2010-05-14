class TwilioResource::TollFreeIncomingPhoneNumber < TwilioResource::IncomingPhoneNumber
  
  self.prefix = superclass.prefix_source + 'IncomingPhoneNumbers/'

  def self.collection_name
    'TollFree'
  end

end
