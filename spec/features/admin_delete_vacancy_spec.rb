require 'rails_helper'

feature 'Admin delete a vacancy' do

  scenario 'sucessfully' do
    company = Company.create!(company_name: 'Batatinha Feliz', city: 'Santo Antonio de Posse - SP',
                              address: 'Rua Dr. Jorge Tibirica, 114', district: 'Centro',
                              cnpj: '12345678000133', site: 'www.batatinhafeliz.com.br')
    user = User.create!(email: 'gvicencotti@email.com', password: '123456', company_id: company.id)
    vacancy = Vacancy.create!(role: 'Analista de Gestão de Riscos Pl', description: 'Elaborar Matriz de Riscos e Controles Internos', 
                              requirements: 'Superior completo em Contabilidade e experiência anterior',
                              localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021', company_id: company.id)
    
    login_as(user, :role => :Admin)
    visit root_path
    click_on 'Vagas'
    click_on vacancy.company.company_name
    click_on 'Deletar'
    
    expect(page).not_to have_content('Batatinha Feliz')
    expect(page).to have_content('Vaga deletada com sucesso!')
  end
end