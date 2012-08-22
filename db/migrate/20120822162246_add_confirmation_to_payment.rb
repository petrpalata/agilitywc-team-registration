class AddConfirmationToPayment < ActiveRecord::Migration
  def change
      change_table :payments do |t|
          t.column :confirmed, :boolean, :default => false
      end
  end
end
