require 'rails_helper'

feature 'Admin sees candidature' do
  scenario 'successfully' do
    company = create(:company)
    user = create(:user, email: 'gustavo@gmail.com')
    other_user = create(:user, role: 5)
    vacancy = create(:vacancy, company_id: company.id)
    candidature = Candidature.create!(vacancy_id: vacancy.id, user_id: user.id)

    login_as(other_user, :role => :Admin)
    visit root_path
    click_on 'Vagas'

    expect(page).to have_content('Número de candidaturas: 1')
  end

  scenario 'and sees candidates' do
    company = create(:company)
    user = create(:user, role: 5, company_id: company.id)
    vacancy = create(:vacancy, company_id: company.id)
    candidature = Candidature.create!(vacancy_id: vacancy.id, user_id: user.id)

    login_as(user, :role => :Admin)
    visit root_path
    click_on 'Vagas'
    click_on vacancy.company.company_name
    click_on 'Candidaturas'

    expect(page).to have_content('Nome completo')
    expect(page).to have_content('CPF')
    expect(page).to have_content('Telefone')
    expect(page).to have_content('Biografia')   
  end

  scenario 'and goes back to vacancy details' do   
    company = create(:company)
    user = create(:user, role: 5, company_id: company.id)
    vacancy = create(:vacancy, company_id: company.id)
    candidature = Candidature.create!(vacancy_id: vacancy.id, user_id: user.id)

    login_as(user, :role => :Admin)
    visit root_path
    click_on 'Vagas'
    click_on vacancy.company.company_name
    click_on 'Candidaturas'
    click_on 'Voltar'
    
    expect(page).to have_content('Analista de Gestão de Riscos Pl')
    expect(page).to have_content('Elaborar Matriz de Riscos e Controles Internos')
    expect(page).to have_content('Superior completo em Contabilidade e experiência anterior')
    expect(page).to have_content('Santo Antonio de Posse - SP')
    expect(page).to have_content('31/03/2021')
  end

  scenario 'and see messages if no candidature received' do
    company = create(:company)
    user = create(:user, role: 5, company_id: company.id)
    vacancy = create(:vacancy, company_id: company.id)

    login_as(user, :role => :Admin)
    visit root_path
    click_on 'Vagas'
    click_on vacancy.company.company_name
    click_on 'Candidaturas'

    expect(page).to have_content('Nenhuma candidatura recebida até o momento.')
  end 
end