require 'rails_helper'

RSpec.describe 'User Login', type: :system do
  before do
    driven_by(:rack_test) # 処理の軽いブラウザで実施する
    @user = create(:user) # FactoryBotを使用してユーザーを作成
  end

  it 'ユーザー名とパスワードが正しい場合、ログインできる' do
    visit new_user_session_path

    fill_in 'user[username]', with: @user.username # ユーザー名を入力
    fill_in 'user[password]', with: @user.password # パスワードを入力
    click_button 'ログイン' # ログインボタンをクリック

    expect(page).to have_content 'ようこそ！' # 成功メッセージを確認
  end

  it 'ユーザー名が間違っている場合、ログインできない' do
    visit new_user_session_path

    fill_in 'user[username]', with: 'invalid_username' # 存在しないユーザー名を入力
    fill_in 'user[password]', with: @user.password # 正しいパスワードを入力
    click_button 'ログイン'

    expect(page).to have_content 'ユーザー名またはパスワードが無効です。' # エラーメッセージを確認
  end

  it 'パスワードが間違っている場合、ログインできない' do
    visit new_user_session_path

    fill_in 'user[username]', with: @user.username # ユーザー名を入力
    fill_in 'user[password]', with: 'wrong_password' # 誤ったパスワードを入力
    click_button 'ログイン'

    expect(page).to have_content 'ユーザー名またはパスワードが無効です。' # エラーメッセージを確認
  end
end
