require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /" do
    it "returns http success and contains welcome message" do
      get '/'
      expect(response).to have_http_status(:success)
      expect(response.body).to include('ようこそ！') # メッセージを確認
    end
  end
end
