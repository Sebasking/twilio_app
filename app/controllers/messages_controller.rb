class MessagesController < ApplicationController
    before_action :authenticate_user!

    def index
        @messages = Message.where(user_id: current_user.id)
        render json: @messages
    end

    def create
        to = params['message']['to']
        body = params['message']['body']
        begin
            TwilioClient.send_message(params['message']['to'], params['message']['body'])
            Message.create!(user_id: current_user.id, to: to, body: body)
            render json: {ok: "Message created"}, status: :created
        rescue => e
            render json: {message: 'Unable to create message', error: "#{e.message}"}, status: :unprocessable_entity
        end
    end
end
 