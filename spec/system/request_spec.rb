require 'rails_helper'

RSpec.describe "RuleModificationRequests", type: :system do
  let!(:team) { create(:team_name, name: "Team A") }
  let!(:user_general) { create(:user, role: :general, team_name_ids: [team.id]) }
  let!(:user_admin) { create(:user, role: :admin, email: 'admin@example.com', username: 'admin_user', team_name_ids: [team.id]) } # 同じチームにする
  let!(:rule) { create(:rule, team_name: team) }

  describe "一般ユーザー" do
    before do
      driven_by(:rack_test) # 処理の軽いブラウザで実施
      sign_in user_general # 一般ユーザーとしてサインイン
    end

    it "ルール一覧にアクセスした際、表示ボタンのみが表示されること" do
      visit rules_path(team_name_id: team.id) # 特定のチームのルール一覧に遷移


      expect(page).to have_content(rule.title) # ルールが表示されている
      expect(page).to have_link('表示') # 表示ボタンがリンクとして表示されていることを確認
      expect(page).not_to have_link('編集') # 編集ボタンが表示されていない
      expect(page).not_to have_link('削除') # 削除ボタンが表示されていない
    end

    it "ルール詳細ページにアクセスした際、修正リクエストボタンが表示されること" do
      visit rule_path(rule) # ルール詳細ページに遷移


      expect(page).to have_link('修正リクエスト') # 修正リクエストボタンがリンクとして表示されていることを確認
    end

    it "他のチームのルールにアクセスしようとした際、見つかりませんという表示がされること" do
      other_team = create(:team_name, name: "Team B")
      other_rule = create(:rule, team_name: other_team)

      visit rules_path(team_name_id: other_team.id) # 他のチームのルール詳細ページに遷移

      expect(page).to have_content("見つかりません") 
    end
  end

  describe "管理者ユーザー" do
    before do
      driven_by(:rack_test) # 処理の軽いブラウザで実施
      sign_in user_admin # 管理者ユーザーとしてサインイン
    end

    it "ルール一覧にアクセスした際、表示、編集、削除ボタンが表示されること" do
      visit rules_path(team_name_id: team.id) # 特定のチームのルール一覧に遷移

      expect(page).to have_content(rule.title) # ルールが表示されている
      expect(page).to have_link('表示') # 表示ボタンがリンクとして表示されていることを確認
      expect(page).to have_link('編集') # 編集ボタンが表示されている
      expect(page).to have_link('削除') # 削除ボタンが表示されている
    end

    it "ヘッダーから修正リクエスト一覧にアクセスできること" do
      visit rules_path(team_name_id: team.id) # 特定のチームのルール一覧に遷移

      # ヘッダープルダウンメニューから修正リクエスト一覧をクリック
      within('nav') do
        click_link '修正リクエスト一覧'
      end

      expect(page).to have_content('修正リクエスト一覧') # 修正リクエスト一覧ページに遷移することを確認
    end
  end
end
