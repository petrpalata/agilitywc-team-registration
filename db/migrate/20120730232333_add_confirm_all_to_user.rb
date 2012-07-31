class AddConfirmAllToUser < ActiveRecord::Migration
  def change
      add_column :users, :confirm_all, :boolean, :default => false
  end
end
