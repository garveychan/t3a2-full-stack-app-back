require 'rails_helper'

RSpec.describe "Checkins", type: :request do
  describe "GET /index" do
    before do 
			get "/checkins"
	  end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "Post /checkins" do
    let(:user) { User.create(email: 'test@test.com', password: 'password', encrypted_password: 'password', role: 'user') }
  
    it "creates a new checkin" do
      post "/checkins", params: { checkin: { user_id: user.id }}
      expect(response).to have_http_status :created
    end
  end
end
