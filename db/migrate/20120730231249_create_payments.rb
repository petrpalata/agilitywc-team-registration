class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :country_id, :unique
      t.timestamps
    end
  end
end
