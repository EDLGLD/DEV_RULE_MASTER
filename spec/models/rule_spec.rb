require 'rails_helper'

RSpec.describe Rule, type: :model do
  it 'タイトル、team_name_id、詳細、背景、および終了日があれば有効であること' do
    rule = create(:rule)  # Ruleファクトリを使用してルールを作成
    expect(rule).to be_valid
  end

  it 'タイトルがない場合、無効であること' do
    rule = build(:rule, title: nil)
    expect(rule).to be_invalid
  end

  it 'team_name_idがない場合、無効であること' do
    rule = build(:rule, team_name_id: nil)
    expect(rule).to be_invalid
  end

  it '詳細がない場合、無効であること' do
    rule = build(:rule, details: nil)
    expect(rule).to be_invalid
  end

  it '背景がない場合、無効であること' do
    rule = build(:rule, background: nil)
    expect(rule).to be_invalid
  end

  it '終了日がない場合、無効であること' do
    rule = build(:rule, ended_at: nil)
    expect(rule).to be_invalid
  end
end
