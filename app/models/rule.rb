class Rule < ApplicationRecord
  belongs_to :team_name
  has_many :rule_requests, dependent: :destroy

  validates :title, presence: true
  validates :details, presence: true
end
