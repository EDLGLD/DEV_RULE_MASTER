class TeamName < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :rules
  validates :name, presence: true, uniqueness: true
end
