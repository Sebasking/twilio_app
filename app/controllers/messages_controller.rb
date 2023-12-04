class MessagesController < ApplicationController
    before_action :authenticate_user!

    def index
        @messages = Message.where(user_id: current_user.id)
        render json: @messages
    end

    def create
        result = TwilioClient.send_message(params['to'], params['body'])
    end

    private
    def message_params
        params.require(:message).permit(:body, :to)
    end
end
