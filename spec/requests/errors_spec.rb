require 'rails_helper'

RSpec.describe 'エラー処理', type: :request do
    describe 'GET /404' do
        it "存在しないパスに対して404エラーページが表示される" do
          get '/404test' # 存在しないパスをリクエスト
          expect(response.body).to include('404') # ページに「404」が含まれていることを確認
        end
    end

    describe 'GET /500' do
        it '500レスポンスを返し、public/500.htmlをレンダリングする' do
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_raise(StandardError) # 意図的にエラーを発生させる
          get '/' # 500エラーを発生させるパスにリクエストを送信
          expect(response).to have_http_status(:internal_server_error) # 500ステータスを確認
          expect(response.body).to include('500') # 500ページの内容を確認
        end
    end
end
