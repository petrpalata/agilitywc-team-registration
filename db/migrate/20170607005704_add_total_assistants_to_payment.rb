class AddTotalAssistantsToPayment < ActiveRecord::Migration
  def change
      change_table :payments do |t|
          t.integer :total_assistants_coaches
      end
  end
end
