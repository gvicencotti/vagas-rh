require 'rails_helper'

feature 'Admin registers new vacancy' do
  scenario 'from index page' do
    visit root_path
    click_on 'Vagas'

    expect(page).to have_link('Cadastrar nova vaga', 
                              href: new_vacancy_path)
  end

  scenario 'succesfully' do
    visit root_path
    click_on 'Vagas'
    click_on 'Cadastrar nova vaga'

    fill_in 'Empresa', with: 'Batatinha Feliz'
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

    expect(page).to have_content('Não foi possível cadastrar a vaga')
    expect(page).to have_content('Não permitido campos em branco', count: 5)
  end

  scenario 'and code must be unique' do
    Vacancy.create!(company: 'Batatinha Feliz', role: 'Analista de Gestão de Riscos Pl',
                    description: 'Elaborar Matriz de Riscos e Controles Internos', 
                    requirements: 'Superior completo em Contabilidade e experiência anterior',
                    localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021')
    
    visit root_path
    click_on 'Vagas'
    click_on 'Cadastrar nova vaga'
    fill_in 'Empresa', with: 'Batatinha Feliz'
    click_on 'Criar vaga'

    expect(page).to have_content('Deve ser único')
  end

end