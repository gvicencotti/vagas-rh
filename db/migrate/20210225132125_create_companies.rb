class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :company_name
      t.string :city
      t.string :address
      t.string :district
      t.string :cnpj
      t.string :site

      t.timestamps
    end
  end
end
