class TwilioClient 
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN'] 
    @@client = Twilio::REST::Client.new(account_sid, auth_token)

    def self.send_message(to, body)
        puts 'did we make it here'
        begin 
            result = @@client.messages.create(
                from: ENV['TWILIO_NUMBER'],
                to: to,
                body: body
            )

            puts result
            result
        rescue Twilio::REST::RestError => e
            puts e
            puts 'It fucking failed'
            e
        end
    end
end