FactoryBot.define do
  factory :user do
    email { 'gustavo@email.com' }
    password { '123456' }
    complete_name { 'Gustavo Vicencotti' }
    cpf { '1234567891011' }
    phone_number { '(99)9999-9999'}
    biography { 'Superior completo em contabilidade' }
  end
end