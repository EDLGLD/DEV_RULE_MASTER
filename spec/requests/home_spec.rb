require 'rails_helper'

RSpec.describe "ホーム", type: :request do
  describe "GET /" do
    it "HTTPステータスが成功で、ウェルカムメッセージを含む" do
      get '/'
      expect(response).to have_http_status(:success)
      expect(response.body).to include('ようこそ！') # メッセージを確認
    end
  end
end
