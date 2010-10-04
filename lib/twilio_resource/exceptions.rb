module TwilioResource
end

# Wraps Twilio exceptions with a ruby exception class. Currently supports:
#   
#    - Error 21452 - No Phone Numbers Found
class TwilioResource::Exception < StandardError

  # Given a twilio error xml response, returns the corresponding
  # exception if it is mapped, or the xml response otherwise.
  def self.find_exception(e)
    new_exception = if e.respond_to?(:response)
      exception_data = ActiveResource::Formats::TwilioFormat.decode(e.response.body)

      code = exception_data['code']
      exception_klass = twilio_exceptions[code.to_i] if code
      exception_klass.nil? ? e : exception_klass.new
    else
      e
    end
  end
  
  # Hash mapping error codes to exception classes.
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
