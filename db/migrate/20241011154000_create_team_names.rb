class CreateTeamNames < ActiveRecord::Migration[6.1]
  def change
    create_table :team_names, id: :bigint do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
