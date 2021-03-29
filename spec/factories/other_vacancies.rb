FactoryBot.define do
  factory :other_vacancy do
    role { 'Cozinheiro A' }
    description { 'Administração da cozinha e preparo de alimentos' }
    requirements { 'Superior completo em Gastronomia e experiência anterior' }
    localization { 'Uberlândia - MG' }
    expiration_date { '31/03/2021'}
  end
end
