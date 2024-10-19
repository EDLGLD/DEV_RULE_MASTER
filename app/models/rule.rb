class Rule < ApplicationRecord
  belongs_to :team_name
  has_many :rule_requests, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :team_name_id, presence: true
  validates :details, presence: true
  validates :background, presence: true
  
end
