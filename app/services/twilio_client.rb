class TwilioClient 
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN'] 
    @@client = Twilio::REST::Client.new(account_sid, auth_token)

    def self.send_message(to, body)
        begin 
            @@client.messages.create(
                from: "+#{ENV['TWILIO_NUMBER']}",
                to: "+#{to}",
                body: body
            )
        rescue Twilio::REST::RestError => e
            e
        end
    end
end