class AddCategoryToDog < ActiveRecord::Migration
  def change
      add_column :dogs, :category, :string
  end
end
