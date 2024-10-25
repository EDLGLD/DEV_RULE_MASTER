require 'rails_helper'

RSpec.describe 'User Registration', type: :system do
  before do
    driven_by(:rack_test) # 処理の軽いブラウザで実施する
    TeamName.create(name: 'Development Team') # チーム名を事前に作成
  end

  after do
    # チーム名に関連するユーザーを削除
    TeamNamesUser.where(team_name_id: TeamName.find_by(name: 'Development Team').id).destroy_all
    # チーム名を削除
    TeamName.where(name: 'Development Team').destroy_all
  end

  it '新しいユーザーが正しい情報で登録できる' do
    visit new_user_registration_path

    fill_in 'user[username]', with: 'testuser' # フィールド名を修正
    fill_in 'user[email]', with: 'testuser@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    check 'Development Team' # チーム名を選択（チェックボックス）
    click_button 'Sign up'

    expect(page).to have_content 'ようこそ！'
    expect(User.last.email).to eq 'testuser@example.com'
  end

  it '必須フィールドが空だと登録できない' do
    visit new_user_registration_path

    fill_in 'user[username]', with: '' # フィールド名を修正
    fill_in 'user[email]', with: 'testuser@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    check 'Development Team'
    click_button 'Sign up'

    expect(page).to have_content 'エラー'
    expect(User.count).to eq(0)
  end
end
