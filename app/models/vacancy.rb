class Vacancy < ApplicationRecord
  validates :role, :description, :requirements, :localization, :expiration_date, presence: true

  enum status: { active: 0, inactive: 5 }

  def self.visitor_valid_vacancies
    Vacancy.where(' status = ? AND expiration_date >= ?', 0, Time.zone.today)
  end

  belongs_to :company
  has_many :candidature

  Vacancy.joins(:company)
  Vacancy.joins(:candidature)
end
