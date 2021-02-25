require 'rails_helper'

feature 'admin register new company' do
  scenario 'successfully' do
    Company.create!(company_name: 'Batatinha Feliz', city: 'Santo Antonio de Posse - SP',
                    address: 'Rua Dr. Jorge Tibirica, 114', district: 'Centro',
                    cnpj: '12345678000133', site: 'www.batatinhafeliz.com.br')
    user = User.create!(email: 'gustavo@batatinhafeliz.com', password: '123456', role: 5)

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

  scenario 'and attributes can´t be blank' do
    Company.create!(company_name: 'Batatinha Feliz', city: 'Santo Antonio de Posse - SP',
                    address: 'Rua Dr. Jorge Tibirica, 114', district: 'Centro',
                    cnpj: '12345678000133', site: 'www.batatinhafeliz.com.br')
    
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
end