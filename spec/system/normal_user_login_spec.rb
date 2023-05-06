require 'rails_helper'

describe "Visitante acessa a tela de Login" do
  it "e ve os campos corretos" do
     visit new_user_session_path

    expect(page).to have_content('Login de Usuário')
    expect(page).to have_field('E-mail')
    expect(page).to have_field('Senha')
    expect(page).to have_button('Logar') 
  end
  
  it "e realiza login como um usuário normal" do
    user = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@provedor.com', password:'password')
    visit new_user_session_path


    fill_in "E-mail",	with: 'joao@provedor.com'
    fill_in "Senha",	with: 'password'
    click_button 'Logar'

    within('nav') do
      expect(page).to have_content('joao@provedor.com')
    end
  end

  it "e os dados errados" do
    user = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@provedor.com', password:'password')
    visit new_user_session_path
  
  
    fill_in "E-mail",	with: 'email@inexistente.com'
    fill_in "Senha",	with: 'password'
    click_button 'Logar'
  
    within('nav') do
      expect(page).not_to have_content('email@inexistente.com')
    end
  end
  
end
