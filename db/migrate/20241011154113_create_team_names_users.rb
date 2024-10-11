class CreateTeamNamesUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :team_names_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :team_name, null: false, foreign_key: true

      t.timestamps
    end
  end
end
