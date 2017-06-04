class AddBasicFieldToStaffMember < ActiveRecord::Migration
  def up
      change_table :staff_members do |t|
          t.integer :role_type
          t.string :full_name
          t.has_attached_file :picture
      end
  end

  def down
      change_table :staff_members do |t|
          t.remove :role_type
          t.remove :full_name
          t.drop_attached_file :picture
      end
  end
end
