class TwilioResource::LocalIncomingPhoneNumber < TwilioResource::IncomingPhoneNumber
  
  self.prefix = superclass.prefix_source + 'IncomingPhoneNumbers/'

  def self.collection_name
    'Local'
  end

end
