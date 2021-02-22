# require 'rails_helper'

# feature 'Visitor complete registration' do
#   scenario 'must be signed in' do
#     visit root_path
#     click_on 'Vagas'

#     expect(current_path).to eq(new_user_session_path)
#   end

#   scenario 'successfully' do
#     user = User.create!(email: 'gustavo@gmail.com', password: '123456')
#     vacancy = Vacancy.create!(company: 'Batatinha Feliz', role: 'Analista de Gestão de Riscos Pl',
#                               description: 'Elaborar Matriz de Riscos e Controles Internos', 
#                               requirements: 'Superior completo em Contabilidade e experiência anterior',
#                               localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021')

#     login_as user, scope: user
#     visit root_path
#     click_on 'Completar cadastro'

    
#   end