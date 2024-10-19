RSpec.describe "/rules", type: :request do
  let(:team_name) { FactoryBot.create(:team_name) }
  let(:admin_user) { FactoryBot.create(:user, role: :admin) } # 管理者ユーザーを作成
  let(:general_user) { FactoryBot.create(:user) } # 一般ユーザーを作成

  let(:valid_attributes) {
    { title: "Test Rule", details: "Some details", background: "Background information", team_name_id: team_name.id }
  }

  let(:invalid_attributes) {
    { title: nil, team_name_id: nil }
  }

  describe "管理者ユーザーによる操作" do
    before do
      sign_in admin_user # 管理者としてサインイン
    end

    describe "GET /index" do
      it "成功レスポンスを返すこと" do
        get rules_url
        expect(response).to be_successful
      end
    end

    describe "GET /new" do
      it "成功レスポンスを返すこと" do
        get new_rule_url
        expect(response).to be_successful
      end
    end

    describe "POST /create" do
      context "有効なパラメータを使用する場合" do
        it "新しいルールを作成すること" do
          expect {
            post rules_url, params: { rule: valid_attributes }
          }.to change(Rule, :count).by(1)
        end

        it "作成したルールのページにリダイレクトすること" do
          post rules_url, params: { rule: valid_attributes }
          expect(response).to redirect_to(rule_url(Rule.last))
        end
      end

      context "無効なパラメータを使用する場合" do
        it "新規作成テンプレートを表示すること" do
          post rules_url, params: { rule: invalid_attributes }
          expect(response).to be_successful
        end
      end
    end

    describe "GET /edit" do
      it "成功レスポンスを返すこと" do
        rule = Rule.create!(valid_attributes)
        get edit_rule_url(rule)
        expect(response).to be_successful
      end
    end

    describe "PATCH /update" do
      context "有効なパラメータを使用する場合" do
        it "リクエストしたルールを更新すること" do
          rule = Rule.create!(valid_attributes)
          patch rule_url(rule), params: { rule: { title: "Updated Rule" } }
          rule.reload
          expect(rule.title).to eq("Updated Rule")
        end

        it "ルールのページにリダイレクトすること" do
          rule = Rule.create!(valid_attributes)
          patch rule_url(rule), params: { rule: { title: "Updated Rule" } }
          expect(response).to redirect_to(rule_url(rule))
        end
      end

      context "無効なパラメータを使用する場合" do
        it "編集テンプレートを表示すること" do
          rule = Rule.create!(valid_attributes)
          patch rule_url(rule), params: { rule: invalid_attributes }
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE /destroy" do
      it "リクエストしたルールを削除すること" do
        rule = Rule.create!(valid_attributes)
        expect {
          delete rule_url(rule)
        }.to change(Rule, :count).by(-1)
      end

      it "ルール一覧ページにリダイレクトすること" do
        rule = Rule.create!(valid_attributes)
        delete rule_url(rule)
        expect(response).to redirect_to(rules_url)
      end
    end
  end

  describe "一般ユーザーによる操作" do
    before do
      sign_in general_user # 一般ユーザーとしてサインイン
    end

    describe "GET /index" do
      it "成功レスポンスを返すこと" do
        get rules_url
        expect(response).to be_successful
      end
    end

    describe "GET /new" do
      it "ルールの新規作成は許可されていない" do
        get new_rule_url
        expect(response).to redirect_to(rules_url) # 適切なリダイレクト先
        expect(flash[:alert]).to eq('ルールの新規作成権限がありません。') # アラートメッセージの確認
      end
    end

    describe "POST /create" do
      it "新規作成は許可されていない" do
        post rules_url, params: { rule: invalid_attributes }
        expect(response).to redirect_to(rules_url) # 適切なリダイレクト先
        expect(flash[:alert]).to eq('ルールの新規作成権限がありません。') # アラートメッセージの確認
      end
    end

    describe "GET /edit" do
      it "編集は許可されていない" do
        rule = Rule.create!(valid_attributes)
        get edit_rule_url(rule)
        expect(response).to redirect_to(rules_url) # 適切なリダイレクト先
        expect(flash[:alert]).to eq('ルールの編集権限がありません。') # アラートメッセージの確認
      end
    end

    describe "PATCH /update" do
      it "更新は許可されていない" do
        rule = Rule.create!(valid_attributes)
        patch rule_url(rule), params: { rule: invalid_attributes }
        expect(response).to redirect_to(rules_url) # 適切なリダイレクト先
        expect(flash[:alert]).to eq('ルールの更新権限がありません。') # アラートメッセージの確認
      end
    end

    describe "DELETE /destroy" do
      it "削除は許可されていない" do
        rule = Rule.create!(valid_attributes)
        delete rule_url(rule)
        expect(response).to redirect_to(rules_url) # 適切なリダイレクト先
        expect(flash[:alert]).to eq('ルールの削除権限がありません。') # アラートメッセージの確認
      end
    end
  end
end
