class AddHandlerIdToDog < ActiveRecord::Migration
  def change
      add_column :dogs, :handler_id, :integer
  end
end
