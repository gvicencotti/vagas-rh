require 'rails_helper'

feature 'Admin sees candidature' do
  scenario 'successfully' do
    company = Company.create!(company_name: 'Batatinha Feliz', city: 'Santo Antonio de Posse - SP',
                              address: 'Rua Dr. Jorge Tibirica, 114', district: 'Centro',
                              cnpj: '12345678000133', site: 'www.batatinhafeliz.com.br') 
    user = User.create!(email: 'gustavo@email.com', password: '123456')
    other_user = User.create!(email: 'gustavo@batatinhafeliz.com', password: '123456', role: 5)
    vacancy = Vacancy.create!(role: 'Analista de Gestão de Riscos Pl',
                              description: 'Elaborar Matriz de Riscos e Controles Internos', 
                              requirements: 'Superior completo em Contabilidade e experiência anterior',
                              localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021', company_id: company.id)
    candidature = Candidature.create!(vacancy_id: vacancy.id, user_id: user.id)

    login_as(other_user, :role => :Admin)
    visit root_path
    click_on 'Vagas'

    expect(page).to have_content('Número de candidaturas:1')
  end

  scenario 'and sees candidates' do
    company = Company.create!(company_name: 'Batatinha Feliz', city: 'Santo Antonio de Posse - SP',
      address: 'Rua Dr. Jorge Tibirica, 114', district: 'Centro',
      cnpj: '12345678000133', site: 'www.batatinhafeliz.com.br') 
    user = User.create!(email: 'gustavo@email.com', password: '123456', complete_name: 'Gustavo Vicencotti',
                        cpf: '1234567891011', phone_number: '(99)9999-9999',
                        biography: 'Superior completo em contabilidade')
    vacancy = Vacancy.create!(role: 'Analista de Gestão de Riscos Pl',
                              description: 'Elaborar Matriz de Riscos e Controles Internos', 
                              requirements: 'Superior completo em Contabilidade e experiência anterior',
                              localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021', company_id: company.id)
    candidature = Candidature.create!(vacancy_id: vacancy.id, user_id: user.id)

    login_as(user, :role => :Admin)
    visit root_path
    click_on 'Vagas'
    click_on 'Candidaturas'

    expect(page).to have_content('Nome completo')
    expect(page).to have_content('CPF')
    expect(page).to have_content('Telefone')
    expect(page).to have_content('Biografia')   
  end
end