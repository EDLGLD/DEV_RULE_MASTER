FactoryBot.define do
  factory :rule_request do
    association :user # Userファクトリと関連付け
    association :rule # Ruleファクトリと関連付け
    request_details { "Request for modification" }
    status { "pending" }
  end
end