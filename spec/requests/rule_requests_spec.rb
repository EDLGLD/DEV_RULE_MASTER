require 'rails_helper'

RSpec.describe "RuleRequests", type: :request do
  let(:team) { create(:team_name, name: "Team Alpha") }
  let(:general_user) { create(:user, role: :general, team_names: [team]) }
  let(:admin_user) { create(:user, role: :admin, team_names: [team], email: "admin_user_unique@example.com", username: "admin_user_unique") }
  let!(:rule) { create(:rule, title: "Sample Rule", team_name: team) }

  describe "一般ユーザーとして" do
    before { sign_in general_user }

    it "修正リクエストを作成できる" do
      # ルールIDを含む修正リクエストの属性を定義
      rule_request_attributes = attributes_for(:rule_request, user: general_user, rule: rule)
      rule_request_attributes[:rule_id] = rule.id # ルールIDを追加

      post rule_requests_path, params: { rule_request: rule_request_attributes }
      
      # サーバーの応答を確認
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(rule_path(rule)) # 修正リクエストに紐づくルールの詳細画面にリダイレクト
      follow_redirect!
      expect(response.body).to include("修正リクエストが送信されました。")
    end
  end

  describe "管理者として" do
    let!(:rule_request) { create(:rule_request, user: general_user, rule: rule) }

    before { sign_in admin_user }

    it "修正リクエストを承認できる" do
      patch rule_request_path(rule_request), params: { status: 'approved' }

      expect(response).to redirect_to(rule_requests_path)
      follow_redirect!
      expect(response.body).to include("リクエストを承認しました。")
      expect(rule_request.reload.status).to eq('approved')
    end

    it "修正リクエストを却下できる" do
      patch rule_request_path(rule_request), params: { status: 'rejected' }

      expect(response).to redirect_to(rule_requests_path)
      follow_redirect!
      expect(response.body).to include("リクエストを却下しました。")
      expect(rule_request.reload.status).to eq('rejected')
    end
  end
end
