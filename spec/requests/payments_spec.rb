require 'rails_helper'

RSpec.describe "Payments", type: :request do
	describe "GET /index" do
		before do 
			get "/payments"
		end
		it "returns http success" do
			expect(response).to have_http_status(:success)
		end
	end
end
