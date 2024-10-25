class CreateRuleRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :rule_requests, id: :bigint do |t|
      t.references :rule, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :request_details, null: false
      t.string :status, null: false, default: 'pending'

      t.timestamps
    end
  end
end
