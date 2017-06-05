class AddReserveFieldToTeam < ActiveRecord::Migration
  def up
      change_table :teams do |t|
          t.date :handler_date_of_birth
          t.boolean :individual
          t.boolean :individual_reserve
          t.boolean :squads
          t.boolean :squads_reserve
      end
  end

  def down
      change_table :teams do |t|
          t.remove :handler_date_of_birth
          t.remove :individual
          t.remove :individual_reserve
          t.remove :squads
          t.remove :squads_reserve
      end
  end
end
