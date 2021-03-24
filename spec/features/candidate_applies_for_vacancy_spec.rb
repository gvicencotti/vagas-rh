require 'rails_helper'

feature 'Candidate apply for vacancy' do
  scenario 'succesfully' do
    company = create(:company)
    user = create(:user)
    vacancy = create(:vacancy, company_id: company.id)

    
    login_as(user, :role => :Candidate)
    visit root_path
    click_on 'Vagas'
    click_on vacancy.company.company_name
    click_on "Candidatar"

    expect(page).to have_content("Candidatura registrada com sucesso!")
  end

  scenario 'and does not see number of candidatures' do
    user = create(:user, role: 0)
    
    login_as(user, :role => :Candidate)
    visit root_path
    click_on 'Vagas'

    expect(page).not_to have_content('Número de candidaturas:')
  end

  scenario 'can´t candidate if profile incomplete' do
    company = create(:company)
    user = User.create!(email: 'gustavo@email.com', password: '123456', role: 0)
    vacancy = create(:vacancy, company_id: company.id)

    login_as(user, :role => :Candidate)
    visit root_path
    click_on 'Vagas'
    click_on vacancy.company.company_name
    click_on 'Candidatar'

    expect(page).not_to have_content('Candidatura registrada com sucesso!')
    expect(page).to have_content('Necessário preencher perfil para se cadastrar a vagas.')
  end
end