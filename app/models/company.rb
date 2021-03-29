class Company < ApplicationRecord
  validates :company_name, :city, :address, :district, :cnpj, :site, presence: true

  has_many :vacancies, through: :users
  has_many :users, through: :vacancies
end
