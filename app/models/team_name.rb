class TeamName < ApplicationRecord
  has_many :team_names_users
  has_many :users, through: :team_names_users
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
end
