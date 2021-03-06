require 'rails_helper'

feature 'Admin registers a valid vacancy' do
  scenario 'and attributes can´t be blank' do  
    company = Company.create!(company_name: 'Batatinha Feliz', city: 'Santo Antonio de Posse - SP',
                              address: 'Rua Dr. Jorge Tibirica, 114', district: 'Centro',
                              cnpj: '12345678000133', site: 'www.batatinhafeliz.com.br')
    user = User.create!(email: 'gustavo@email.com', password: '123456', complete_name: 'Gustavo Vicencotti',
                        cpf: '1234567891011', phone_number: '(99)9999-9999',
                        biography: 'Superior completo em contabilidade', role: 5, company_id: company.id)
                        
    login_as(user, :role => :Admin)
    visit root_path
    click_on 'Vagas'
    click_on 'Cadastrar nova vaga'
    fill_in 'Cargo', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Requisitos', with: ''
    fill_in 'Localização', with: ''
    fill_in 'Data de expiração', with: ''
    click_on 'Criar vaga'

    expect(Vacancy.count).to eq 0
    expect(page).to have_content('Não foi possível salvar vaga')
    expect(page).to have_content('Cargo não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Requisitos não pode ficar em branco')
    expect(page).to have_content('Data de expiração não pode ficar em branco')
  end
end
