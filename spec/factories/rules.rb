FactoryBot.define do
  factory :rule do
    title { "Sample Rule" }
    details { "Details of the rule" }
    background { "Background of the rule" }
    association :team_name # TeamNameファクトリを関連付け
  end
end