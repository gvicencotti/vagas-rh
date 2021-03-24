require 'rails_helper'

feature 'Candidate receives job proposal' do
  scenario 'successfully' do
    company = create(:company)
    user = create(:user, company_id: company.id)
    vacancy = create(:vacancy, company_id: company.id)
    candidature = Candidature.create!(vacancy_id: vacancy.id, user_id: user.id, status: 5)
    candidature_approval = create(:candidature_approval, candidature_id: candidature.id)

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Candidaturas'
    click_on 'Ver proposta'

    expect(page).to have_content('Salário')
    expect(page).to have_content('Data de início')  
  end

  scenario 'or gets job candidature denied' do
    company = create(:company)
    user = create(:user, company_id: company.id)
    vacancy = create(:vacancy, company_id: company.id)
    candidature = Candidature.create!(vacancy_id: vacancy.id, user_id: user.id, status: 10)
    candidature_approval = create(:candidature_denial, candidature_id: candidature.id)

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Candidaturas'
    click_on 'Ver feedback'

    expect(page).to have_content('Feedback da empresa')
  end
end