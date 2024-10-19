class TeamNamesUser < ApplicationRecord
  belongs_to :user
  belongs_to :team_name

  validates :user_id, presence: true
  validates :team_name_id, presence: true
end
