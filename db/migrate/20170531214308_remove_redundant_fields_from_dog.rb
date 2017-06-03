class RemoveRedundantFieldsFromDog < ActiveRecord::Migration
  def up
      add_column :dogs, :name, :string
      remove_column :dogs, :nickname
      remove_column :dogs, :studbook_and_number
      remove_column :dogs, :record_book_or_license
      remove_column :dogs, :breed_id
      add_column :dogs, :country_id, :integer
  end

  def down
      remove_column :dogs, :name, :string
      add_column :dogs, :nickname, :string
      add_column :dogs, :studbook_and_number, :string
      add_column :dogs, :record_book_or_license, :string
      add_column :dogs, :breed_id, :integer
      remove_column :dogs, :country_id
  end
end
