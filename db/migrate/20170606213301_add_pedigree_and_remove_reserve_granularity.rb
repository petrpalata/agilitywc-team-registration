class AddPedigreeAndRemoveReserveGranularity < ActiveRecord::Migration
  def up
      change_table :teams do |t|
          t.has_attached_file :pedigree
          t.remove :squads_reserve
          t.remove :individual_reserve
      end
  end

  def down
      change_table :teams do |t|
          t.remove :pedigree
          t.boolean :squads_reserve
          t.boolean :individual_reserve
      end
  end
end
