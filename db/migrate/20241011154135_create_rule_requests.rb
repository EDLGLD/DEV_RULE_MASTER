class CreateRuleRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :rule_requests do |t|
      t.references :rule, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :request_details
      t.string :status

      t.timestamps
    end
  end
end
