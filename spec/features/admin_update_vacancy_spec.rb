require 'rails_helper'

feature 'Admin update vacancy' do

  scenario 'attributes cannot be blank' do
    user = User.create!(email: 'gvicencotti@email.com', password: '123456')
    vacancy = Vacancy.create!(company: 'Batatinha Feliz', role: 'Analista de Gestão de Riscos Pl',
                              description: 'Elaborar Matriz de Riscos e Controles Internos', 
                              requirements: 'Superior completo em Contabilidade e experiência anterior',
                              localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021')

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Vagas'
    click_on vacancy.company
    click_on 'Editar'
    fill_in 'Empresa', with: ''
    fill_in 'Cargo', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Requisitos', with: ''
    fill_in 'Localização', with: ''
    fill_in 'Data de expiração', with: ''
    click_on 'Salvar'

    expect(Vacancy.count).to eq(1)
    expect(page).to have_content('Não foi possível editar a vaga')
    expect(page).to have_content('Empresa não pode ficar em branco')
    expect(page).to have_content('Cargo não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Requisitos não pode ficar em branco')
    expect(page).to have_content('Localização não pode ficar em branco')
    expect(page).to have_content('Data de expiração não pode ficar em branco')
  end


  scenario 'succesfully' do
    user = User.create!(email: 'gvicencotti@email.com', password: '123456')
    vacancy = Vacancy.create!(company: 'Batatinha Feliz', role: 'Analista de Gestão de Riscos Pl',
                              description: 'Elaborar Matriz de Riscos e Controles Internos', 
                              requirements: 'Superior completo em Contabilidade e experiência anterior',
                              localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021')

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Vagas'
    click_on vacancy.company
    click_on 'Editar'
    fill_in 'Empresa', with: 'Batatinha Feliz'
    fill_in 'Cargo', with: 'Contador'
    fill_in 'Descrição', with: 'Confeccionar demonstrações financeiras'
    fill_in 'Requisitos', with: 'Superior completo em Contabilidade'
    fill_in 'Localização', with: 'Santo Antonio de Posse - SP'
    fill_in 'Data de expiração', with: '31/04/2021'
    click_on 'Salvar'
    
    expect(current_path).to eq vacancy_path(vacancy)
    expect(page).to have_content('Batatinha Feliz')
  end
end