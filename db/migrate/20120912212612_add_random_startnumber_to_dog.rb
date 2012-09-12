class AddRandomStartnumberToDog < ActiveRecord::Migration
  def change
      change_table :dogs do |t|
          t.column :start_number, :integer
      end
  end
end
