require 'rails_helper'

feature 'Visitor visit home page' do
  scenario 'successfully' do

    visit root_path

    expect(page).to have_content('VagasRH')
    expect(page).to have_content('Bem vindo ao maior site de vagas de emprego do Brasil!')
  end
end