class MessagesController < ApplicationController
    before_action :authenticate_user!

    def index
        @messages = Message.where(user_id: current_user.id)
        render json: @messages
    end

    def create
        # debugger
        result = TwilioClient.send_message(params['to'], params['body'])
        puts result
    end

    private
    def message_params
        params.require(:message).permit(:body, :to)
    end
end
