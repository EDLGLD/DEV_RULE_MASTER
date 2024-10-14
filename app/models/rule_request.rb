class RuleRequest < ApplicationRecord
  belongs_to :rule
  belongs_to :user
end
