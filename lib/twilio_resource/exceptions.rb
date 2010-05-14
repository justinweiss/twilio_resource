module TwilioResource
end

class TwilioResource::Exception < StandardError

  def self.find_exception(e)
    new_exception = if e.respond_to?(:response)
      exception_data = Hash.from_xml(e.response.body)

      
      code = exception_data['twilio_response'] && 
          exception_data['twilio_response']['rest_exception'] && 
          exception_data['twilio_response']['rest_exception']['code']
      exception_klass = twilio_exceptions[code.to_i] if code
      exception_klass.nil? ? e : exception_klass.new
    else
      e
    end
  end
  
  def self.twilio_exceptions
    {
      21452 => TwilioResource::NoPhoneNumbersFoundException,
    }
  end
  
end

class TwilioResource::NoPhoneNumbersFoundException < TwilioResource::Exception
  def message
    "No phone numbers found"
  end
end
