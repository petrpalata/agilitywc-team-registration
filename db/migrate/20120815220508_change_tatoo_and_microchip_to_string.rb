class ChangeTatooAndMicrochipToString < ActiveRecord::Migration
  def up
      change_table :dogs do |t|
          t.change :microchip, :string
          t.change :tatoo, :string
      end
  end

  def down
      change_table :dogs do |t|
          t.change :microchip, :integer
          t.change :tatoo, :integer
      end
  end
end
