require 'rails_helper'

feature 'Candidate apply for vacancy' do
  scenario 'succesfully' do
    company = Company.create!(company_name: 'Batatinha Feliz', city: 'Santo Antonio de Posse - SP',
                              address: 'Rua Dr. Jorge Tibirica, 114', district: 'Centro',
                              cnpj: '12345678000133', site: 'www.batatinhafeliz.com.br')
    user = User.create!(email: 'gustavo@email.com', password: '123456', role: 0)
    vacancy = Vacancy.create!(role: 'Analista de Gestão de Riscos Pl', description: 'Elaborar Matriz de Riscos e Controles Internos', 
                              requirements: 'Superior completo em Contabilidade e experiência anterior',
                              localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021', company: company)
    
    login_as(user, :role => :Candidato)
    visit root_path
    click_on 'Vagas'
    click_on vacancy.company.company_name
    click_on "Candidatar"

    expect(page).to have_content("Candidatura registrada com sucesso!")
  end
end