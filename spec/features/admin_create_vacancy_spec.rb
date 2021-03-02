require 'rails_helper'

feature 'Admin registers new vacancy' do
  scenario 'from index page' do
    visit root_path
    click_on 'Vagas'

    expect(page).to have_link('Cadastrar nova vaga', 
                              href: new_vacancy_path)
  end

  scenario 'succesfully' do
    company = Company.create!(company_name: 'Batatinha Feliz', city: 'Santo Antonio de Posse - SP',
                              address: 'Rua Dr. Jorge Tibirica, 114', district: 'Centro',
                              cnpj: '12345678000133', site: 'www.batatinhafeliz.com.br')
    user = User.create!(email: 'gustavo@email.com', password: '123456', company_id: company.id)
    
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Vagas'
    click_on 'Cadastrar nova vaga'
    fill_in 'Cargo', with: 'Analista de Gestão de Riscos Pl'
    fill_in 'Descrição', with: 'Elaborar Matriz de Riscos e Controles Internos'
    fill_in 'Requisitos', with: 'Superior completo em Contabilidade e experiência anterior'
    fill_in 'Localização', with: 'Santo Antonio de Posse - SP'
    fill_in 'Data de expiração', with: '31/03/2021'
    click_on 'Criar vaga'

    vacancy = Vacancy.last
    expect(current_path).to eq(vacancy_path(vacancy))
    expect(page).to have_content('Batatinha Feliz')
    expect(page).to have_content('Analista de Gestão de Riscos Pl')
    expect(page).to have_content('Elaborar Matriz de Riscos e Controles Internos')
    expect(page).to have_content('Superior completo em Contabilidade e experiência anterior')
    expect(page).to have_content('Santo Antonio de Posse - SP')
    expect(page).to have_content('31/03/2021')
    expect(page).to have_link('Voltar')
  end
end