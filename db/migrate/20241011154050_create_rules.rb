class CreateRules < ActiveRecord::Migration[6.1]
  def change
    create_table :rules do |t|
      t.string :title
      t.references :team_name, null: false, foreign_key: true
      t.text :details
      t.text :background
      t.datetime :ended_at

      t.timestamps
    end
  end
end
