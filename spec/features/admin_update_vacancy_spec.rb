require 'rails_helper'

feature 'Admin update vacancy' do

  scenario 'attributes cannot be blank' do
    company = Company.create!(company_name: 'Batatinha Feliz', city: 'Santo Antonio de Posse - SP',
                              address: 'Rua Dr. Jorge Tibirica, 114', district: 'Centro',
                              cnpj: '12345678000133', site: 'www.batatinhafeliz.com.br')
    user = User.create!(email: 'gustavo@email.com', password: '123456', complete_name: 'Gustavo Vicencotti',
                        cpf: '1234567891011', phone_number: '(99)9999-9999',
                        biography: 'Superior completo em contabilidade', role: 5, company_id: company.id)
    vacancy = Vacancy.create!(role: 'Analista de Gestão de Riscos Pl',
                              description: 'Elaborar Matriz de Riscos e Controles Internos', 
                              requirements: 'Superior completo em Contabilidade e experiência anterior',
                              localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021', company_id: company.id)

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
    company = Company.create!(company_name: 'Batatinha Feliz', city: 'Santo Antonio de Posse - SP',
                              address: 'Rua Dr. Jorge Tibirica, 114', district: 'Centro',
                              cnpj: '12345678000133', site: 'www.batatinhafeliz.com.br')
    user = User.create!(email: 'gustavo@email.com', password: '123456', complete_name: 'Gustavo Vicencotti',
                        cpf: '1234567891011', phone_number: '(99)9999-9999',
                        biography: 'Superior completo em contabilidade', role: 5, company_id: company.id)
    vacancy = Vacancy.create!(role: 'Analista de Gestão de Riscos Pl',
                              description: 'Elaborar Matriz de Riscos e Controles Internos', 
                              requirements: 'Superior completo em Contabilidade e experiência anterior',
                              localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021', company_id: company.id)

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
    company = Company.create!(company_name: 'Batatinha Feliz', city: 'Santo Antonio de Posse - SP',
                              address: 'Rua Dr. Jorge Tibirica, 114', district: 'Centro',
                              cnpj: '12345678000133', site: 'www.batatinhafeliz.com.br')
    user = User.create!(email: 'gvicencotti@email.com', password: '123456')
    vacancy = Vacancy.create!(role: 'Analista de Gestão de Riscos Pl',
                              description: 'Elaborar Matriz de Riscos e Controles Internos', 
                              requirements: 'Superior completo em Contabilidade e experiência anterior',
                              localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021', company_id: company.id)

    login_as(user, :role => :Candidate)
    visit root_path
    click_on 'Vagas'
    click_on vacancy.company.company_name

    expect(page).not_to have_link('Editar')
    expect(page).not_to have_link('Deletar')    
  end 
end