require 'rails_helper'

feature 'Admin denies a candidature' do
  scenario 'successfully' do
    company = create(:company)
    user = create(:user, role: 5, company_id: company.id)
    vacancy = Vacancy.create!(role: 'Analista de Gestão de Riscos Pl', description: 'Elaborar Matriz de Riscos e Controles Internos', 
                              requirements: 'Superior completo em Contabilidade e experiência anterior',
                              localization: 'Santo Antonio de Posse - SP', expiration_date: '31/03/2021', company_id: company.id)
    candidature = Candidature.create!(vacancy_id: vacancy.id, user_id: user.id)
    candidature_denial = CandidatureDenial.create!(candidature_id: candidature.id, feedback: 'Faltou curso superior')

    login_as(user, :role => :Admin)
    visit root_path
    click_on 'Vagas'
    click_on vacancy.company.company_name
    click_on 'Candidaturas'
    click_on 'Recusar candidatura'
    fill_in 'Feedback', with: 'Faltou curso superior'
    click_on 'Enviar feedback'


    expect(page).to have_content('Feedback enviado com sucesso.')
  end
end