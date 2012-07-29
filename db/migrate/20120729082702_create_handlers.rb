class CreateHandlers < ActiveRecord::Migration
  def change
    create_table :handlers do |t|
      t.string :first_name
      t.string :last_name
      t.integer :country_id
      t.integer :user_id
      t.boolean :insurance

      t.timestamps
    end
  end
end
