class RuleRequest < ApplicationRecord
  belongs_to :rule
  belongs_to :user

  validates :request_details, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending approved rejected] }
end
