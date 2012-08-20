class CreateTeamParticipations < ActiveRecord::Migration
  def change
    create_table :team_participations do |t|
      t.integer :country_id
      t.boolean :small
      t.boolean :medium
      t.boolean :large

      t.timestamps
    end
  end
end
