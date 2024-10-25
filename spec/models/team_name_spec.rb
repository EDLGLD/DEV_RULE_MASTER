require 'rails_helper'

RSpec.describe TeamName, type: :model do
  it '名前があれば有効である' do
    team_name = TeamName.new(name: 'Development Team')
    expect(team_name).to be_valid
  end

  it '名前がない場合は無効である' do
    team_name = TeamName.new(name: nil)
    expect(team_name).to be_invalid
  end

  it '重複した名前の場合は無効である' do
    TeamName.create(name: 'Development Team')
    team_name = TeamName.new(name: 'Development Team')
    expect(team_name).to be_invalid
  end
end
