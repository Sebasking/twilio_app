require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "GET /index" do
    it "ensure that the user is signed in" do
      first_message = 'this is my message'
      second_message = 'another message'

      @user = User.create!(email: 'someemail@gmail.com', password: 'somepassword')
      Message.create!(user_id: @user.id, to: '55555555', body: first_message)
      Message.create!(user_id: @user.id, to: '55555555', body: second_message)
      sign_in @user
      get "/api/v1/users/#{@user.id}/messages"
      parsed_response = JSON.parse(response.body)
      expect(parsed_response[0]['body']).to eq(first_message)
      expect(parsed_response[1]['body']).to eq(second_message)
    end

    it 'does not respond with messages for user that is not logged in' do
      first_message = 'this is my message'
      second_message = 'another message'
      @user = User.create!(email: 'someemail@gmail.com', password: 'somepassword')
      Message.create!(user_id: @user.id, to: '55555555', body: first_message)
      Message.create!(user_id: @user.id, to: '55555555', body: second_message)
      get "/api/v1/users/#{@user.id}/messages"
    end
  end
end
