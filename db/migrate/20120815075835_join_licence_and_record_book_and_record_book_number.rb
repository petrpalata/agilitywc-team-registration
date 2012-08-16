class JoinLicenceAndRecordBookAndRecordBookNumber < ActiveRecord::Migration
  def up
      change_table :dogs do |t|
        t.change :record_book, :string
        t.rename :record_book, :record_book_or_license
        t.remove :license
      end
  end

  def down
      change_table :dogs do |t|
          t.column :license, :string
          t.rename :record_book_or_license, :record_book
      end
  end
end
