class CreateVacancies < ActiveRecord::Migration[6.1]
  def change
    create_table :vacancies do |t|
      t.string :company
      t.string :role
      t.text :description
      t.text :requirements
      t.string :localization
      t.date :expiration_date

      t.timestamps
    end
  end
end
