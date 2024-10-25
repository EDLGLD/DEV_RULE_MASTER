require 'rails_helper'

RSpec.describe RuleRequest, type: :model do
  let(:user) { create(:user) }  # ユーザーを生成
  let(:rule) { create(:rule) }   # ルールを生成
  let(:rule_request) { build(:rule_request, user: user, rule: rule) } # RuleRequestをファクトリで生成

  context 'バリデーションのテスト' do
    it 'is valid with a rule_id, user_id, request_details, and status' do
      expect(rule_request).to be_valid
    end

    it 'rule_idがない場合、無効であること' do
      rule_request.rule_id = nil
      expect(rule_request).to be_invalid
      expect(rule_request.errors[:rule]).to include("を入力してください")  # エラーメッセージも確認
    end

    it 'user_idがない場合、無効であること' do
      rule_request.user_id = nil
      expect(rule_request).to be_invalid
      expect(rule_request.errors[:user]).to include("を入力してください")  # エラーメッセージも確認
    end

    it 'request_detailsがない場合、無効であること' do
      rule_request.request_details = nil
      expect(rule_request).to be_invalid
      expect(rule_request.errors[:request_details]).to include("を入力してください")  # エラーメッセージも確認
    end

    it 'statusがない場合、無効であること' do
      rule_request.status = nil
      expect(rule_request).to be_invalid
      expect(rule_request.errors[:status]).to include("を入力してください")  # エラーメッセージも確認
    end

    it 'pending、approved、rejected以外のstatusがある場合、無効であること' do
      rule_request.status = 'invalid_status'
      expect(rule_request).to be_invalid
      expect(rule_request.errors[:status]).to include("は一覧にありません")  # エラーメッセージも確認
    end
  end
end
