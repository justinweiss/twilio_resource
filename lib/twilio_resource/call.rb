
# Encapsulates a Twilio call resource. Documentation:
# - http://www.twilio.com/docs/api/2008-08-01/rest/call
# - http://www.twilio.com/docs/api/2008-08-01/rest/making_calls
class TwilioResource::Call < TwilioResource::Base
  belongs_to :account

  NOT_DIALED = "queued"
  IN_PROGRESS = "in-progress"
  COMPLETE = "completed"
  RINGING = "ringing"
  FAILED = "failed"
  BUSY = "busy"
  NO_ANSWER = "no-answer"

  # old end-point
  def called
    self.to
  end

  # old end-point
  def caller
    self.from
  end

  # old end-point
  def call_segment_sid
    self.parent_call_sid
  end

end
