class AddReserveToDog < ActiveRecord::Migration
  def change
      add_column :dogs, :reserve, :boolean, :default => false
  end
end
