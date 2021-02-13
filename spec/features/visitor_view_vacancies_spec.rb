require 'rails_helper'

feature 'Visitor view vacancies' do
  scenario 'successfully' do
    Vacancy.create!(company: 'Batatinha Feliz', role: 'Analista de Gestão de Riscos Pl',
                    description: 'Elaborar Matriz de Riscos e Controles Internos', 
                    requirements: 'Superior completo em Contabilidade e experiência anterior',
                    localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021')
    Vacancy.create!(company: 'Bife Achatado Empreedimentos', role: 'Cozinheiro A',
                    description: 'Administração da cozinha e preparo de alimentos',
                    requirements: 'Superior completo em Gastronomia e experiência anterior',
                    localization: 'Uberlândia - MG', expiration_date: '31/03/2021')
  
    visit root_path
    click_on 'Vagas'

    expect(page).to have_content('Batatinha Feliz')
    expect(page).to have_content('Analista de Gestão de Riscos Pl')
    expect(page).to have_content('Bife Achatado Empreedimentos')
    expect(page).to have_content('Cozinheiro A')
  end

  scenario 'and view details' do
    Vacancy.create!(company: 'Batatinha Feliz', role: 'Analista de Gestão de Riscos Pl',
                    description: 'Elaborar Matriz de Riscos e Controles Internos', 
                    requirements: 'Superior completo em Contabilidade e experiência anterior',
                    localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021')
    Vacancy.create!(company: 'Bife Achatado Empreedimentos', role: 'Cozinheiro A',
                    description: 'Administração da cozinha e preparo de alimentos',
                    requirements: 'Superior completo em Gastronomia e experiência anterior',
                    localization: 'Uberlândia - MG', expiration_date: '31/03/2021')

    visit root_path
    click_on 'Vagas'
    click_on 'Batatinha Feliz'

    expect(page).to have_content('Batatinha Feliz')
    expect(page).to have_content('Analista de Gestão de Riscos Pl')
    expect(page).to have_content('Elaborar Matriz de Riscos e Controles Internos')
    expect(page).to have_content('Superior completo em Contabilidade e experiência anterior')
    expect(page).to have_content('Santo Antonio de Posse - SP')
    expect(page).to have_content('31/03/2021')
  end
end