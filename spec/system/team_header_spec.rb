require 'rails_helper'

RSpec.describe 'チーム名ヘッダー', type: :system do
  let(:user) { create(:user, username: 'test_user') }
  let(:team_name_a) { create(:team_name, name: 'Team A') }
  let(:team_name_b) { create(:team_name, name: 'Team B') }

  before do
    driven_by(:rack_test) # beforeブロック内に移動

    user.team_names << team_name_a
    user.team_names << team_name_b
    visit new_user_session_path
    fill_in 'user[username]', with: user.username
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  it 'ヘッダーに正しいチーム名が表示される' do
    within('nav.navbar') do
      expect(page).to have_content('Team A')
      expect(page).to have_content('Team B')
    end
  end
end
