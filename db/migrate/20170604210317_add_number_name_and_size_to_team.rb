class AddNumberNameAndSizeToTeam < ActiveRecord::Migration
  def up
      change_table :teams do |t|
          t.string :number_size
          t.string :number_name
      end
  end

  def down
      change_table :teams do |t|
          t.remove :number_size
          t.remove :number_name
      end
  end
end
