require 'rails_helper'

feature 'Candidate see candidatures' do
  scenario 'successfully' do
    company = Company.create!(company_name: 'Batatinha Feliz', city: 'Santo Antonio de Posse - SP',
                              address: 'Rua Dr. Jorge Tibirica, 114', district: 'Centro',
                              cnpj: '12345678000133', site: 'www.batatinhafeliz.com.br')
    user = User.create!(email: 'gustavo@email.com', password: '123456', complete_name: 'Gustavo Vicencotti',
                        cpf: '1234567891011', phone_number: '(99)9999-9999',
                        biography: 'Superior completo em contabilidade')
    vacancy = Vacancy.create!(role: 'Analista de Gestão de Riscos Pl', description: 'Elaborar Matriz de Riscos e Controles Internos', 
                              requirements: 'Superior completo em Contabilidade e experiência anterior',
                              localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021', company_id: company.id)
    candidature = Candidature.create!(vacancy_id: vacancy.id, user_id: user.id)
    
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Candidaturas'
    
    expect(page).to have_content(company.company_name)
    expect(page).to have_content(vacancy.role)
  end

  scenario 'and goes back to home page' do
    company = Company.create!(company_name: 'Batatinha Feliz', city: 'Santo Antonio de Posse - SP',
                              address: 'Rua Dr. Jorge Tibirica, 114', district: 'Centro',
                              cnpj: '12345678000133', site: 'www.batatinhafeliz.com.br')
    user = User.create!(email: 'gustavo@email.com', password: '123456', complete_name: 'Gustavo Vicencotti',
                        cpf: '1234567891011', phone_number: '(99)9999-9999',
                        biography: 'Superior completo em contabilidade')
    vacancy = Vacancy.create!(role: 'Analista de Gestão de Riscos Pl', description: 'Elaborar Matriz de Riscos e Controles Internos', 
                              requirements: 'Superior completo em Contabilidade e experiência anterior',
                              localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021', company_id: company.id)
    candidature = Candidature.create!(vacancy_id: vacancy.id, user_id: user.id)

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Candidaturas'
    click_on 'Voltar'

    expect(page).to have_content('Bem vindo ao maior site de vagas de emprego do Brasil!')
  end
end