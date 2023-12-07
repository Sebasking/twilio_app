# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  respond_to :json

  private 

  def respond_with(current_user, _opts = {})
    puts(current_user.inspect)
    puts(_opts)
    if request.method == "POST" && resource.persisted?
      render json: {
        status: {code: 200, message: 'Signed up successfully.'},
        data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }, status: :ok
    elsif request.method == 'DELETE'
      render json: {
        status: {code: 200, message: "Account deleted successfully"}
      }, status: :ok
    else
      puts(resource.errors.full_messages.to_sentence)
      render json: {
        message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}",
        status: {code: 422}
      }, status: :unprocessable_entity
    end
  end
end
