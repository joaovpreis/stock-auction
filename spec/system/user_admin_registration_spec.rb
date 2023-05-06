require 'rails_helper'

describe "Visitante acessa a tela de cadastro" do
  it "e ve os campos corretos" do
     visit new_user_registration_path

    expect(page).to have_content('Cadastro de Usuário')
    expect(page).to have_field('Nome')
    expect(page).to have_field('CPF')
    expect(page).to have_field('E-mail')
    expect(page).to have_field('Senha')
    expect(page).to have_field('Confirmação da Senha')
    expect(page).to have_button('Cadastrar') 
  end
  
  it "e se cadastra como usuário regular" do
    visit new_user_registration_path

    fill_in "Nome",	with: 'João Guilherme'
    fill_in "CPF",	with: '89698395008'
    fill_in "E-mail",	with: 'joao@gmail.com'
    fill_in "Senha",	with: '1234567890'
    fill_in "Nome",	with: '1234567890' 
    fill_in "Confirmação da Senha",	with: '1234567890'

    click_on 'Cadastrar'

    within('nav') do
      expect(page).to have_content('joao@gmail.com')
    end
  end

  it "e preenche o formulario com dados errados" do
    visit new_user_registration_path

    fill_in "Nome",	with: 'João Guilherme'
    fill_in "CPF",	with: ''
    fill_in "E-mail",	with: 'joao@gmail.com'
    fill_in "Senha",	with: '9876543210'
    fill_in "Confirmação da Senha",	with: '1234567890'

    click_on 'Cadastrar'

    within('nav') do
      expect(page).not_to have_content('joao@gmail.com')
    end
  end
  
end
