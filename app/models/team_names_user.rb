class TeamNamesUser < ApplicationRecord
  belongs_to :user
  belongs_to :team_name
end
