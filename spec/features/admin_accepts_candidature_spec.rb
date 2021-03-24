require 'rails_helper'

feature 'Admin accepts a candidature' do
  scenario 'successfully' do
    company = create(:company)
    user = create(:user, role: 5, company_id: company.id)
    vacancy = create(:vacancy, company_id: company.id)
    candidature = Candidature.create!(vacancy_id: vacancy.id, user_id: user.id)
    candidature_approval = create(:candidature_approval, candidature_id: candidature.id)

    login_as(user, :role => :Admin)
    visit root_path
    click_on 'Vagas'
    click_on vacancy.company.company_name
    click_on 'Candidaturas'
    click_on 'Aceitar candidatura'
    fill_in 'Proposta salarial', with: 'R$2000'
    fill_in 'Data de início', with: '25/03/2021'
    click_on 'Enviar proposta'

    expect(page).to have_content('Proposta enviada com sucesso.')
  end

  scenario 'and goes back to candidature list' do
    company = create(:company)
    user = create(:user, role: 5, company_id: company.id)
    vacancy = create(:vacancy, company_id: company.id)
    candidature = Candidature.create!(vacancy_id: vacancy.id, user_id: user.id)

    login_as(user, :role => :Admin)
    visit root_path
    click_on 'Vagas'
    click_on vacancy.company.company_name
    click_on 'Candidaturas'
    click_on 'Aceitar candidatura'
    click_on 'Voltar'

    expect(page).to have_content('Nome completo')
    expect(page).to have_content('CPF')
  end
end
   