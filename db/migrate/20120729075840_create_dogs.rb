class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.string :nickname
      t.string :registered_name
      t.integer :breed_id
      t.date :date_of_birth
      t.string :studbook
      t.integer :studbook_number
      t.string :record_book
      t.string :license
      t.integer :tatoo
      t.integer :microchip
      t.string :microchip_position
      t.integer :user_id
      t.string :owner_first_name
      t.string :owner_last_name
      t.text :owner_address
      t.string :owner_phone_number

      t.timestamps
    end
  end
end
