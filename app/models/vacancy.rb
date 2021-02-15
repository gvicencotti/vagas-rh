class Vacancy < ApplicationRecord
  
  enum status: { active: 0, inactive: 5 }

  def self.visitor_valid_vacancies
    Vacancy.where(' status = ? AND expiration_date >= ?', 0, Date.today)
  end

end
