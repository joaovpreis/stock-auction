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
end
