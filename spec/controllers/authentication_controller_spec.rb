require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  describe "POST authenticate" do
    it "should reject user that isn't in database" do
      post 'authenticate', params: {email: "thief@thief.com", password: "i_am_thief"}
      expect(response).to have_http_status(:unauthorized)
    end

    it "should return token to verified user" do
      user = create(:user)
      params = { email: user.email, password: user.password, role: user.role }
      post 'authenticate', params: params, format: :json
      expect(response.content_type).to eq('application/json')
    end
  end
end
