FactoryBot.define do
  factory :company do
    company_name { 'Batatinha Feliz' }
    city { 'Santo Antonio de Posse - SP' }
    address { 'Rua Dr. Jorge Tibirica, 114' }
    district { 'Centro' }
    cnpj { '12345678000133'}
    site { 'www.batatinhafeliz.com.br' }
  end
end