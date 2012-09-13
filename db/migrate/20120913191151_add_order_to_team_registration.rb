class AddOrderToTeamRegistration < ActiveRecord::Migration
  def change
      change_table :team_participations do |t|
          t.column :small_order, :integer, :default => 0
          t.column :medium_order, :integer, :default => 0
          t.column :large_order, :integer, :default => 0
      end
  end
end
