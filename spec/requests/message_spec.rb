require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "GET /show" do
    it "ensure that the user is signed in" do
      @user = User.create!(email: 'someemail@gmail.com', password: 'somepassword')
      sign_in @user
      debugger
    end
  end
end
