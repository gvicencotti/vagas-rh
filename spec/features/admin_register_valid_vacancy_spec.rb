require 'rails_helper'

feature 'Admin registers a valid vacancy' do
  scenario 'and attributes can´t be blank' do    
    visit root_path
    click_on 'Vagas'
    click_on 'Cadastrar nova vaga'
    fill_in 'Empresa', with: ''
    fill_in 'Cargo', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Requisitos', with: ''
    fill_in 'Localização', with: ''
    fill_in 'Data de expiração', with: ''
    click_on 'Criar vaga'

    expect(Vacancy.count).to eq 0
    expect(page).to have_content('Não foi possível cadastrar a vaga')
    expect(page).to have_content('Empresa não pode ficar em branco')
    expect(page).to have_content('Cargo não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Requisitos não pode ficar em branco')
    expect(page).to have_content('Data de expiração não pode ficar em branco')
  end
end