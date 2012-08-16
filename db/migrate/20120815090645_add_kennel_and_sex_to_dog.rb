class AddKennelAndSexToDog < ActiveRecord::Migration
  def change
      change_table :dogs do |t|
          t.column :sex, :string
          t.column :kennel, :string
      end
  end
end
