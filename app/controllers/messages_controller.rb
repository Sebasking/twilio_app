class MessagesController < ApplicationController
    before_action :authenticate_user!

    def index
        @messages = Message.where(user_id: current_user.id)
        render json: @messages
    end

    def create
        result = TwilioClient.send_message(params['to'], params['body'])

        if (result.status_code != "200")
            {status: :bad_request, message: "Something with wrong"}.to_json 
        else
            begin
                Message.create!(user_id: current_user.id, to: params['to'], body: params['body'])
            rescue => exception
                 
            end
        end
    end

    private
    def message_params
        params.require(:message).permit(:body, :to)
    end
end
