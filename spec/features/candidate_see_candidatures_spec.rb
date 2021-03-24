require 'rails_helper'

feature 'Candidate see candidatures' do
  scenario 'successfully' do
    company = create(:company)
    user = create(:user)
    vacancy = create(:vacancy, company_id: company.id)
    candidature = Candidature.create!(vacancy_id: vacancy.id, user_id: user.id)
    
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Candidaturas'
    
    expect(page).to have_content(company.company_name)
    expect(page).to have_content(vacancy.role)
  end

  scenario 'and goes back to home page' do
    company = create(:company)
    user = create(:user)
    vacancy = create(:vacancy, company_id: company.id)
    candidature = Candidature.create!(vacancy_id: vacancy.id, user_id: user.id)

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Candidaturas'
    click_on 'Voltar'

    expect(page).to have_content('Bem vindo ao maior site de vagas de emprego do Brasil!')
  end
end