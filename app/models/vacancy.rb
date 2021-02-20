class Vacancy < ApplicationRecord
  validates :company, :role, :description, :requirements, :localization, :expiration_date, presence: true
    
  enum status: { active: 0, inactive: 5 }

  def self.visitor_valid_vacancies
    Vacancy.where(' status = ? AND expiration_date >= ?', 0, Date.today)
  end

end
