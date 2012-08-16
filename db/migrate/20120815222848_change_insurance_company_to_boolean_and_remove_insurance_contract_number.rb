class ChangeInsuranceCompanyToBooleanAndRemoveInsuranceContractNumber < ActiveRecord::Migration
  def up
      change_table :handlers do |t|
          t.change :insurance_company, :boolean
          t.rename :insurance_company, :insurance
          t.remove :insurance_contract_number
      end
  end

  def down
      change_table :handlers do |t|
          t.column :insurance_contract_number, :string
          t.rename :insurance, :insurance_company
          t.change :insurance_company, :string
      end
  end
end
