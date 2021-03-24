require 'rails_helper'

feature 'Admin update vacancy' do

  scenario 'attributes cannot be blank' do
    company = create(:company)
    user = create(:user, role: 5, company_id: company.id)
    vacancy = create(:vacancy, company_id: company.id)

    login_as(user, :role => :Admin)
    visit root_path
    click_on 'Vagas'
    click_on vacancy.company.company_name
    click_on 'Editar'
    fill_in 'Cargo', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Requisitos', with: ''
    fill_in 'Localização', with: ''
    fill_in 'Data de expiração', with: ''
    click_on 'Salvar'

    expect(Vacancy.count).to eq(1)
    expect(page).to have_content('Não foi possível editar a vaga')
    expect(page).to have_content('Cargo não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Requisitos não pode ficar em branco')
    expect(page).to have_content('Localização não pode ficar em branco')
    expect(page).to have_content('Data de expiração não pode ficar em branco')
  end


  scenario 'succesfully' do
    company = create(:company)
    user = create(:user, role: 5, company_id: company.id)
    vacancy = create(:vacancy, company_id: company.id)

    login_as(user, :role => :Admin)
    visit root_path
    click_on 'Vagas'
    click_on vacancy.company.company_name
    click_on 'Editar'
    fill_in 'Cargo', with: 'Contador'
    fill_in 'Descrição', with: 'Confeccionar demonstrações financeiras'
    fill_in 'Requisitos', with: 'Superior completo em Contabilidade'
    fill_in 'Localização', with: 'Santo Antonio de Posse - SP'
    fill_in 'Data de expiração', with: vacancy.expiration_date.strftime('%d/%m/%Y')
    click_on 'Salvar'
    
    expect(current_path).to eq vacancy_path(vacancy)
    expect(page).to have_content('Batatinha Feliz')
  end

  scenario 'and candidate can´t edit or delete vacancy' do
    company = create(:company)
    user = User.create!(email: 'gvicencotti@email.com', password: '123456')
    vacancy = create(:vacancy, company_id: company.id)

    login_as(user, :role => :Candidate)
    visit root_path
    click_on 'Vagas'
    click_on vacancy.company.company_name

    expect(page).not_to have_link('Editar')
    expect(page).not_to have_link('Deletar')    
  end 
end