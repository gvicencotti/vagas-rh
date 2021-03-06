# require 'rails _helper'

# feature 'Candidate see candidatures' do
#   user = User.create!(email: 'gustavo@email.com', password: '123456', complete_name: 'Gustavo Vicencotti',
#                       cpf: '1234567891011', phone_number: '(99)9999-9999',
#                       biography: 'Superior completo em contabilidade', role: 0)
#   candidature = Candidature.create!(vacancy_id: vacancy.id, user_id: user.id)

#   visit root_path
#   click_on 'Candidaturas'

#   expect(page).to have_content()
# end