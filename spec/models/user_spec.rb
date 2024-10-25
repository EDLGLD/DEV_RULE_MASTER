require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with an email, username, and password' do
    user = build(:user) # FactoryBotを使用してユーザーを作成
    expect(user).to be_valid
  end

  it 'is invalid without an email' do
    user = build(:user, email: nil) # emailをnilにしてユーザーを作成
    expect(user).to be_invalid
  end

  it 'is invalid without a unique email' do
    create(:user, email: 'test@example.com') # 既存のユーザーを作成
    user = build(:user, email: 'test@example.com', username: 'newuser') # 同じメールアドレスで新しいユーザーを作成
    expect(user).to be_invalid
  end

  it 'is invalid without a username' do
    user = build(:user, username: nil) # usernameをnilにしてユーザーを作成
    expect(user).to be_invalid
  end

  it 'is invalid with a duplicate username' do
    create(:user, username: 'testuser') # 既存のユーザーを作成
    user = build(:user, email: 'new@example.com', username: 'testuser') # 同じユーザー名で新しいユーザーを作成
    expect(user).to be_invalid
  end

  it 'is invalid without a role' do
    user = build(:user, role: nil) # roleをnilにしてユーザーを作成
    expect(user).to be_invalid
  end
end