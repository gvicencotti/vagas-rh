require 'rails_helper'

feature 'Candidate receives job proposal' do
  scenario 'successfully' do
    company = Company.create!(company_name: 'Batatinha Feliz', city: 'Santo Antonio de Posse - SP',
      address: 'Rua Dr. Jorge Tibirica, 114', district: 'Centro',
      cnpj: '12345678000133', site: 'www.batatinhafeliz.com.br')
    user = User.create!(email: 'gustavo@email.com', password: '123456', complete_name: 'Gustavo Vicencotti',
                        cpf: '1234567891011', phone_number: '(99)9999-9999',
                        biography: 'Superior completo em contabilidade', company_id: company.id)
    vacancy = Vacancy.create!(role: 'Analista de Gestão de Riscos Pl', description: 'Elaborar Matriz de Riscos e Controles Internos', 
                              requirements: 'Superior completo em Contabilidade e experiência anterior',
                              localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021', company_id: company.id)
    candidature = Candidature.create!(vacancy_id: vacancy.id, user_id: user.id, status: 5)
    candidature_approval = CandidatureApproval.create!(candidature_id: candidature.id, salarial_proposal: 'R$2000', start_date: '25/03/2021')

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Candidaturas'
    click_on 'Ver proposta'

    expect(page).to have_content('Salário')
    expect(page).to have_content('Data de início')  
  end

  scenario 'or gets job candidature denied' do
    company = Company.create!(company_name: 'Batatinha Feliz', city: 'Santo Antonio de Posse - SP',
      address: 'Rua Dr. Jorge Tibirica, 114', district: 'Centro',
      cnpj: '12345678000133', site: 'www.batatinhafeliz.com.br')
    user = User.create!(email: 'gustavo@email.com', password: '123456', complete_name: 'Gustavo Vicencotti',
                        cpf: '1234567891011', phone_number: '(99)9999-9999',
                        biography: 'Superior completo em contabilidade', company_id: company.id)
    vacancy = Vacancy.create!(role: 'Analista de Gestão de Riscos Pl', description: 'Elaborar Matriz de Riscos e Controles Internos', 
                              requirements: 'Superior completo em Contabilidade e experiência anterior',
                              localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021', company_id: company.id)
    candidature = Candidature.create!(vacancy_id: vacancy.id, user_id: user.id, status: 10)
    candidature_approval = CandidatureDenial.create!(candidature_id: candidature.id, feedback: 'Não deu')

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Candidaturas'
    click_on 'Ver feedback'

    expect(page).to have_content('Feedback da empresa')
  end
end