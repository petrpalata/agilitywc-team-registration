class AddShowCountryToUser < ActiveRecord::Migration
  def up
      change_table :users do |t|
          t.boolean :show_country, default: true
      end
  end

  def down
      change_table :users do |t|
          t.delete :show_country
      end
  end
end
