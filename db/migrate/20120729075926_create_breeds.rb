class CreateBreeds < ActiveRecord::Migration
  def change
    create_table :breeds do |t|
      t.string :name
      t.integer :fci_number

      t.timestamps
    end
  end
end
