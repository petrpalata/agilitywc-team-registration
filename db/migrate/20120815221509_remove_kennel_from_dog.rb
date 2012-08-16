class RemoveKennelFromDog < ActiveRecord::Migration
  def up
      change_table :dogs do |t|
          t.remove :kennel
      end
  end

  def down
      change_table :dogs do |t|
          t.column :kennel, :string
      end
  end
end
