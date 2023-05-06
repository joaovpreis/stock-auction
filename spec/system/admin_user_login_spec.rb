require 'rails_helper'

describe 'Visitante acessa a tela de Login' do
  it 'e realiza login como um usuário normal' do
    user = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    visit new_user_session_path


    fill_in 'E-mail',	with: 'joao@leilaodogalpao.com.br'
    fill_in 'Senha',	with: 'password'
    click_button 'Logar'

    within('nav') do
      expect(page).to have_content('joao@leilaodogalpao.com.br')
      expect(page).to have_content('Administrador')
      expect(page).not_to have_content('Usuário')
      expect(page).not_to have_content('Cadastrar-se')
      expect(page).not_to have_content('Logar')
    end
  end

  it 'e os dados errados' do
    user = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    visit new_user_session_path
  
  
    fill_in 'E-mail',	with: 'email@inexistente.com'
    fill_in 'Senha',	with: 'password'
    click_button 'Logar'
  
    within('nav') do
      expect(page).not_to have_content('email@inexistente.com')
      expect(page).not_to have_content('Sair')
      expect(page).not_to have_content('Usuário')
      expect(page).not_to have_content('Administrador')
    end
  end

  it 'e faz lougout' do
    user = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    visit new_user_session_path
  
  
    fill_in 'E-mail',	with: 'joao@leilaodogalpao.com.br'
    fill_in 'Senha',	with: 'password'
    click_button 'Logar'

    click_button 'Sair'
    within('nav') do
      expect(page).not_to have_content('email@inexistente.com')
      expect(page).not_to have_content('Sair')
      expect(page).not_to have_content('Usuário')
      expect(page).not_to have_content('Administrador')
    end

  end
  
end
