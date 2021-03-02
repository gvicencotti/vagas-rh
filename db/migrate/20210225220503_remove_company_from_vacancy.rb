class RemoveCompanyFromVacancy < ActiveRecord::Migration[6.1]
  def change
    remove_column :vacancies, :company, :string
  end
end
