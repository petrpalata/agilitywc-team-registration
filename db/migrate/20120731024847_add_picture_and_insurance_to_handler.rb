class AddPictureAndInsuranceToHandler < ActiveRecord::Migration
  def change
      remove_column :handlers, :insurance
      add_column :handlers, :insurance_company, :string
      add_column :handlers, :insurance_contract_number, :string
      change_table :handlers do |t|
          t.has_attached_file :picture
      end
  end
end
