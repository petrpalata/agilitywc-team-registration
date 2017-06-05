class AddDressNumberPhoneNumberEmailToStaffMember < ActiveRecord::Migration
  def up
      change_table :staff_members do |t|
          t.string :number_size
          t.string :number_name
          t.string :phone_number
          t.string :email
      end
  end

  def down
      change_table :staff_members do |t|
          t.remove :number_size
          t.remove :number_name
          t.remove :phone_number
          t.remove :email
      end
  end
end
