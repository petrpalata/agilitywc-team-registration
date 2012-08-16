class JoinStudbookAndStudbookNumber < ActiveRecord::Migration
  def up
      change_table :dogs do |t|
          t.rename :studbook, :studbook_and_number
          t.remove :studbook_number
      end
  end

  def down
      change_table :dogs do |t|
          t.column :studbook_number, :string
      end
  end
end
