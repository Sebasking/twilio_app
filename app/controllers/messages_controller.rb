class MessagesController < ApplicationController
    before_action :authenticate_user!

    def index
        @messages = Message.where(user_id: current_user.id)
        render json: @messages
    end

    def create 
        puts 'did i make it here'
        puts params
        result = TwilioClient.send_message(from: message_params['from'], to: message['to'])
        puts result
    end

    private
    def message_params
        params.require(:message).permit(:body, :to)
    end
end
