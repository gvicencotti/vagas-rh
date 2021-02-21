require 'rails_helper'

feature 'Admin delete a promotion' do

  pending scenario 'sucessfully' do
    vacancy = Vacancy.create!(company: 'Batatinha Feliz', role: 'Analista de Gestão de Riscos Pl',
                              description: 'Elaborar Matriz de Riscos e Controles Internos', 
                              requirements: 'Superior completo em Contabilidade e experiência anterior',
                              localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021')
    
    visit root_path
    click_on 'Vagas'
    click_on 'Deletar'
    
    expect(current_path).to eq vacancy_path
    expect(page).to have_content('Vaga deletada com sucesso!')
  end
end