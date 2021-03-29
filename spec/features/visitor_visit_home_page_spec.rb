require 'rails_helper'

feature 'Visitor visit home page' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_content('VagasRH')
    expect(page).to have_content('Bem vindo ao maior site de vagas de emprego do Brasil!')
  end

  scenario 'and search for vacancy' do
    company = create(:company)
    create(:vacancy, company_id: company.id)

    visit root_path
    fill_in 'Busca:', with: company.company_name
    click_on 'Pesquisar'

    expect(current_path).to eq search_path
    expect(page).to have_content('Analista de Gestão de Riscos Pl')
    expect(page).to have_content('Batatinha Feliz')
    expect(page).not_to have_content('Superior completo em Gastronomia e experiência anterior')
  end

  scenario 'and view vacancy details' do
    company = create(:company)
    user = create(:user, company_id: company.id)
    vacancy = create(:vacancy, company_id: company.id)
    
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Vagas'
    click_on vacancy.company.company_name

    expect(page).to have_content('Elaborar Matriz de Riscos e Controles Internos')
    expect(page).to have_content('Superior completo em Contabilidade e experiência anterior')
    expect(page).to have_content('Santo Antonio de Posse - SP')
    expect(page).to have_content('31/03/2021')
  end

  scenario 'and does not see profile button if not signed in' do
    visit root_path

    expect(page).to_not have_content('Perfil')
  end
end
