class AddCountryToStaffMember < ActiveRecord::Migration
  def up
      change_table :staff_members do |t|
          t.integer :country_id
      end
  end

  def down
      change_table :staff_members do |t|
          t.remove :country_id
      end
  end
end
