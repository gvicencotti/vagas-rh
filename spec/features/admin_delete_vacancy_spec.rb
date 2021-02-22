require 'rails_helper'

feature 'Admin delete a promotion' do

  scenario 'sucessfully' do
    vacancy = Vacancy.create!(company: 'Batatinha Feliz', role: 'Analista de Gestão de Riscos Pl',
                              description: 'Elaborar Matriz de Riscos e Controles Internos', 
                              requirements: 'Superior completo em Contabilidade e experiência anterior',
                              localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021')
    
    visit root_path
    click_on 'Vagas'
    click_on vacancy.company
    click_on 'Deletar'
    
    expect(page).not_to have_content('Batatinha Feliz')
    expect(page).to have_content('Vaga deletada com sucesso!')
  end
end