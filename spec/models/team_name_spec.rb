require 'rails_helper'

RSpec.describe TeamName, type: :model do
  it 'is valid with a name' do
    team_name = TeamName.new(name: 'Development Team')
    expect(team_name).to be_valid
  end

  it 'is invalid without a name' do
    team_name = TeamName.new(name: nil)
    expect(team_name).to be_invalid
  end

  it 'is invalid with a duplicate name' do
    TeamName.create(name: 'Development Team')
    team_name = TeamName.new(name: 'Development Team')
    expect(team_name).to be_invalid
  end
end