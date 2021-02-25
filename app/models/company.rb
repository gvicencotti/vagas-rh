class Company < ApplicationRecord
  validates :company_name, :city, :address, :district, :cnpj, :site, presence: true
end
