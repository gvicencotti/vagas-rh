class Company < ApplicationRecord
  validates :company_name, :city, :address, :district, :cnpj, :site, presence: true

  has_many :vacancies
  has_one :user
 
end
