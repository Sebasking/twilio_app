class MessagesController < ApplicationController
    before_action :authenticate_user!

    def show
        @messages = Message.find(:all, :conditions => ["user_id = ?", current_user.id])
        render json: messages
    end

    def create 

    end

    private
    def message_params
        params.require(:message).permit(:body, :to)
    end
end
