require 'rails_helper'

feature 'User sign up' do
  scenario 'see the button to register' do
    visit root_path
    click_on 'Entrar'

    expect(page).to have_link "Inscrever-se"
    expect(page).to have_link "Esqueceu a senha?"
  end

  scenario 'attributes cannot be blank' do
    visit root_path
    click_on 'Entrar'
    click_on 'Inscrever-se'
    choose 'Admin'
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirme sua senha', with: ''
    click_on 'Cadastrar'

    expect(page).to have_content('E-mail não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
    expect(current_path).not_to eq(root_path)
  end

  scenario 'and email must be unique' do
    user = User.create!(email: 'gustavo@email.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    click_on 'Inscrever-se'
    choose 'Admin'
    fill_in 'E-mail', with: 'gustavo@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Cadastrar'

    expect(current_path).not_to eq(root_path)
    expect(page).not_to have_content('Login efetuado com sucesso.')
    expect(page).to have_content('E-mail já está em uso')
  end

  scenario 'password and password confirmation must be equal' do
    visit root_path
    click_on 'Entrar'
    click_on 'Inscrever-se'
    choose 'Admin' 
    fill_in 'E-mail', with: 'gustavo@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Senha', with: '654321'
    click_on 'Cadastrar'

    expect(current_path).not_to eq(root_path)
    expect(page).to have_content('Confirme sua senha não é igual a Senha')
  end

  scenario 'successfully' do
    visit root_path
    click_on 'Entrar'
    click_on 'Inscrever-se'
    choose 'Admin'
    fill_in 'E-mail', with: 'gustavo@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Cadastrar'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso')
    expect(page).to have_link('Sair')
  end

end