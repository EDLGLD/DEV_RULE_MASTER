# spec/requests/rules_spec.rb
require 'rails_helper'

RSpec.describe "Rules", type: :request do
  let(:team) { create(:team_name, name: "Team Alpha") }
  let(:general_user) { create(:user, role: :general, team_names: [team]) }
  let(:admin_user) { create(:user, role: :admin, team_names: [team]) }
  let!(:rule) { create(:rule, title: "Sample Rule", team_name: team) }

  describe "一般ユーザーとして" do
    before { sign_in general_user }

    it 'ルールの一覧にアクセスできる' do
      get rules_path(team_name_id: team.id)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(rule.title)
    end

    it "ルールの新規作成ページにアクセスできない" do
      get new_rule_path
      expect(response).to redirect_to(rules_path(team_name_id: team.id)) # ここを修正
      follow_redirect!
      expect(response.body).to include("ルールの新規作成権限がありません。")
    end
  
    it "ルールを編集できない" do
      get edit_rule_path(rule)
      expect(response).to redirect_to(rules_path(team_name_id: team.id)) # ここを修正
      follow_redirect!
      expect(response.body).to include("ルールの新規作成権限がありません。")
    end
  
    it "ルールを削除できない" do
      expect {
        delete rule_path(rule)
      }.not_to change(Rule, :count)
      expect(response).to redirect_to(rules_path(team_name_id: team.id)) # ここを修正
    end
  end

  describe "管理者として" do
    before { sign_in admin_user }

    it 'ルールの一覧にアクセスできる' do
      get rules_path(team_name_id: team.id)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(rule.title)
    end

    it "ルールの新規作成ページにアクセスできる" do
      get new_rule_path
      expect(response).to have_http_status(:success)
    end

    it "ルールを新規作成できる" do
      new_rule_attributes = attributes_for(:rule)
      new_rule_attributes[:team_name_id] = team.id # チームIDを明示的に設定
    
      post rules_path, params: { rule: new_rule_attributes }
    
      # エラーメッセージを表示
      if response.status == 422
        puts response.body # エラーメッセージを表示
      end
    
      expect(response).to have_http_status(:redirect) # リダイレクトを期待
    end

    it "ルールを編集できる" do
      patch rule_path(rule), params: { rule: { title: "Updated Rule" } }
      expect(response).to redirect_to(rule_path(rule))
      follow_redirect!
      rule.reload
      expect(rule.title).to eq("Updated Rule")
    end

    it "ルールを削除できる" do
      expect {
        delete rule_path(rule)
      }.to change(Rule, :count).by(-1)
      expect(response).to redirect_to(rules_path(team_name_id: rule.team_name_id))
      follow_redirect!
      expect(response.body).to include("ルールが正常に削除されました。")
    end
  end
end
