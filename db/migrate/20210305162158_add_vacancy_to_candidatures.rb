class AddVacancyToCandidatures < ActiveRecord::Migration[6.1]
  def change
    add_reference :candidatures, :vacancy, null: false, foreign_key: true
  end
end
