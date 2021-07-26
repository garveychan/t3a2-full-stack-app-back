require 'rails_helper'

RSpec.describe "Checkins", type: :request do
  describe "GET /index" do
    before do 
			get "/checkins"
	  end

    it "should return an error if user is not admin" do
      expect(response).to have_http_status(401)
    end
  end

end
