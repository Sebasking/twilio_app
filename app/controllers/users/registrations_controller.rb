# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  respond_to :json

  private 

  def respond_with(current_user, _opts = {})
    if resource.persisted?
      render json: {
        status: {code: 200, message: 'Signed up successfully.'},
        data: current_user.to_json
      }
    else
      render json: {
        status: "User couldn't be created successfully",
        status: :unprocessable_entity
      }
    end
  end
end
