require 'rails_helper'

feature 'admin register new company' do
  scenario 'successfully' do
    user = user = create(:user, role: 5)

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Cadastrar empresa'
    fill_in 'Nome da empresa', with: 'Batatinha Feliz'
    fill_in 'Cidade', with: 'Santo Antonio de Posse - SP'
    fill_in 'Endereço', with: 'Rua Dr. Jorge Tibirica, 114' 
    fill_in 'Bairro', with: 'Centro'
    fill_in 'CNPJ', with: '12345678000133'
    fill_in 'Site', with: 'www.batatinhafeliz.com.br'
    click_on 'Cadastrar'

    expect(page).to have_content('Batatinha Feliz')
    expect(page).to have_content('Santo Antonio de Posse - SP')
    expect(page).to have_content('Rua Dr. Jorge Tibirica, 114' )
    expect(page).to have_content('Centro')
    expect(page).to have_content('12345678000133')
    expect(page).to have_content('www.batatinhafeliz.com.br')
  end

  scenario 'and does not see button if company already registered' do
    company = create(:company)
    user = create(:user, role: 5, company_id: company.id)
    

    login_as(user, :role => :Admin)
    visit root_path

    expect(page).to_not have_link('Cadastrar empresa')
    expect(page).to have_link('Informações da empresa')                  
  end

  scenario 'and attributes can´t be blank' do
    user = create(:user, role: 5)
    
    login_as(user, :role => :Admin)
    visit root_path
    click_on 'Cadastrar empresa'
    fill_in 'Nome da empresa', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Endereço', with: '' 
    fill_in 'Bairro', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Site', with: ''
    click_on 'Cadastrar'

    expect(page).to have_content('Não foi possível cadastrar a empresa')
    expect(page).to have_content('Nome da empresa não pode ficar em branco')
    expect(page).to have_content('Cidade não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('Bairro não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Site não pode ficar em branco')
  end

  scenario 'admin can´t register new company if profile not completed' do
    user = User.create!(email: 'gustavo@email.com', password: '123456', role: 5)
    
    login_as(user, :role => :Admin)
    visit root_path
    click_on 'Cadastrar empresa'

    expect(page).to have_content('Necessário preencher o perfil antes de cadastrar nova empresa.')
    expect(page).to have_content('Editar Perfil')
  end

  scenario 'admin register new company and goes back to home page' do
    company = create(:company)
    user = create(:user, role: 5)

    login_as(user, :role => :Admin)
    visit root_path
    click_on 'Cadastrar empresa'
    fill_in 'Nome da empresa', with: 'Batatinha Feliz'
    fill_in 'Cidade', with: 'Santo Antonio de Posse - SP'
    fill_in 'Endereço', with: 'Rua Dr. Jorge Tibirica, 114' 
    fill_in 'Bairro', with: 'Centro'
    fill_in 'CNPJ', with: '12345678000133'
    fill_in 'Site', with: 'www.batatinhafeliz.com.br'
    click_on 'Cadastrar'
    click_on 'Voltar para home'

    expect(current_path).to eq root_path
    expect(page).to have_content('Bem vindo ao maior site de vagas de emprego do Brasil!')
  end

  scenario 'admin sees company information after registration' do
    company = create(:company)
    user = create(:user, role: 5, company_id: company.id)

    login_as(user, :role => :Admin)
    visit root_path
    click_on 'Informações da empresa'

    expect(page).to have_content('Batatinha Feliz')
    expect(page).to have_content('Santo Antonio de Posse - SP')
    expect(page).to have_content('Rua Dr. Jorge Tibirica, 114')
    expect(page).to have_content('Centro')
    expect(page).to have_content('12345678000133')
    expect(page).to have_content('www.batatinhafeliz.com.br')
  end
end