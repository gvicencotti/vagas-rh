require 'rails_helper'

feature 'Candidate complete registration' do
  scenario 'must be signed in' do
    user = User.create!(email: 'gustavo@email.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'gustavo@email.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    
    expect(page).to have_content('Login efetuado com sucesso.')
    expect(page).to have_content(user.email)
  end

  scenario 'successfully' do
    user = User.create!(email: 'gustavo@email.com', password: '123456', complete_name: 'Gustavo Vicencotti',
                        cpf: '12345678910', phone_number: '(99)9999-9999',
                        biography: 'Superior completo em contabilidade experiência anterior')

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Perfil' 
    click_on 'Editar perfil'
    fill_in 'Nome completo', with: 'Gustavo Vicencotti'
    fill_in 'CPF', with: '12345678910'
    fill_in 'Telefone', with: '(99)9999-9999'
    fill_in 'Biografia', with: 'Superior completo em contabilidade experiência anterior'
    click_on 'Atualizar'
      
    expect(current_path).to eq user_path
    expect(page).to have_content('Gustavo Vicencotti')
    expect(page).to have_content('12345678910')
    expect(page).to have_content('(99)9999-9999')
    expect(page).to have_content('Superior completo em contabilidade experiência anterior')
  end

  scenario 'attributes cannot be blank' do
    user = User.create!(email: 'gustavo@email.com', password: '123456', complete_name: 'Gustavo Vicencotti',
                        cpf: '12345678910', phone_number: '(99)9999-9999',
                        biography: 'Superior completo em contabilidade experiência anterior')
    
    login_as(user, :scope => :user)
    visit root_path 
    click_on 'Perfil'
    click_on 'Editar perfil' 
    fill_in 'Nome completo', with: ''
    fill_in 'CPF', with: ''
    fill_in 'Telefone', with: ''
    fill_in 'Biografia', with: ''
    click_on 'Atualizar'

    expect(page).to have_content('Nome completo não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')
    expect(page).to have_content('Telefone não pode ficar em branco')
    expect(page).to have_content('Biografia não pode ficar em branco')
  end

  scenario 'and cancel user' do
    user = User.create!(email: 'gustavo@email.com', password: '123456')

    login_as(user, :role => :Candidate)
    visit root_path
    click_on 'Perfil'
    click_on 'Editar perfil'
    click_on 'Cancelar minha conta'

    expect(current_path).to eq current_path
    expect(page).to have_content('Adeus! A sua conta foi cancelada com sucesso. Esperamos vê-lo novamente em breve.')  
  end
end