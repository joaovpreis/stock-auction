require 'rails_helper'

describe "Visitante acessa a página principal" do
  it "e visualiza um cabeçalho" do
    visit root_path

    expect(page).to have_content('Leilão de Galpões')
    expect(page).to have_content('Cadastrar-se')
    expect(page).to have_content('Logar')
  end
  
  it "e acessa a página de login" do
    visit root_path

    click_on ('Logar')

    expect(page).to have_current_path(new_user_session_path)
  end
  
  it "e acessa a página de cadastro" do
    visit root_path

    click_on ('Cadastrar-se')

    expect(page).to have_current_path(new_user_registration_path)
  end

  it "e não ve o link para categorias for um usuario normal" do
    user = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@gmail.com.br', password:'password')
    login_as(user)
    visit root_path


    expect(page).not_to have_link('Categorias')
  end

  it "e não ve o link para criar itens se for um usuario normal" do
    user = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@gmail.com.br', password:'password')
    login_as(user)
    visit root_path


    expect(page).not_to have_link('Criar Item')
  end
end

describe "Administrador acessa a página principal" do
  it "e ve o link para categorias for um usuario normal" do
    user = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(user)
    visit root_path


    expect(page).to have_link('Categorias')
  end

  it "e ve o link para criar itens se for um usuario normal" do
    user = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(user)
    visit root_path


    expect(page).to have_link('Criar Item')
  end
end