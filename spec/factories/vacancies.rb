FactoryBot.define do
  factory :vacancy do
    role { 'Analista de Gestão de Riscos Pl' }
    description { 'Elaborar Matriz de Riscos e Controles Internos' }
    requirements { 'Superior completo em Contabilidade e experiência anterior' }
    localization { 'Santo Antonio de Posse - SP' }
    expiration_date { '31/03/2021'}
  end
end
