FactoryBot.define do
  factory :rule_request do
    rule { nil }
    user { nil }
    request_details { "MyText" }
    status { "MyString" }
  end
end
