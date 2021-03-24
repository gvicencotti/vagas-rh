require 'rails_helper'

feature 'Admin delete a vacancy' do

  scenario 'sucessfully' do
    company = create(:company)
    user = create(:user, role: 5, company_id: company.id)
    vacancy = create(:vacancy, company_id: company.id)
    
    login_as(user, :role => :Admin)
    visit root_path
    click_on 'Vagas'
    click_on vacancy.company.company_name
    click_on 'Deletar'
    
    expect(page).not_to have_content('Batatinha Feliz')
    expect(page).to have_content('Vaga deletada com sucesso!')
  end
end