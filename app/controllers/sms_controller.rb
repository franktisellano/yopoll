class SmsController < ApplicationController

  # Twilio constants – should be moved to config
  # ACCOUNT_SID = 'ACd619abfb51473fa45265088dbf7cbf7d'
  # ACCOUNT_TOKEN = 'a5225b03b9cfee05ffcf539bf58c6492'

  def receive

    message_body = params["Body"]
    score = Integer(message_body.gsub(/[^0-9]/, ""))
    from_number = params["From"]
    to_number = params["To"]

    @twilio_client = Twilio::REST::Client.new ACCOUNT_SID, ACCOUNT_TOKEN

    @active_poll = Poll.where("phone_number = ? AND active = ?", to_number, true).first
    @active_demo = Demo.where("active = ? AND poll_id = ?", true, @active_poll.id).first

    if score.between?(1,3)
      @vote = Vote.new(demo_id: @active_demo.id, from: from_number, raw: message_body, score: score)
      if @vote.save

        # Let's save money on twilio.
        # @twilio_client.account.sms.messages.create(
        #   :from => to_number,
        #   :to => from_number,
        #   :body => "Success! You gave a score of #{score}."
        # )      

        Pusher['dashboard_channel'].trigger('add_score', data: {
          'score' => score,
          'team_id'=> @active_demo.id
        })

        render :nothing => true, :status => 200, :content_type => 'text/html'
      else
        @twilio_client.account.sms.messages.create(
          :from => to_number,
          :to => from_number,
          :body => "Your score could not be submitted. You can only vote for a team one time."
        )
      end

    else


      @twilio_client.account.sms.messages.create(
        :from => to_number,
        :to => from_number,
        :body => "Your vote must be between 1 and 3."
      )

      render :nothing => true, :status => 200, :content_type => 'text/html'
    end
  end

  # def send
  # end
end
