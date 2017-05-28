class RenameHandlerTableToTeams < ActiveRecord::Migration
  def up
      rename_table :handlers, :teams
  end

  def down
      rename_table :teams, :handlers
  end
end
