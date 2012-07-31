class AddCostAndTotalTeamsToPayment < ActiveRecord::Migration
  def change
      add_column :payments, :total_teams, :integer
      add_column :payments, :price_in_euros, :integer
  end
end
