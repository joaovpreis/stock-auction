require 'rails_helper'

describe "Administrador acessa a a listagem de categoria" do
  it "e ve as categorias existentes" do
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    Category.create!(name: 'Eletrônicos')
    Category.create!(name: 'Vestuário')
    login_as(admin)
    visit root_path

    click_on 'Categorias'

    expect(page).to have_content('Categorias:')
    expect(page).to have_content('Eletrônicos')
    expect(page).to have_content('Vestuário')

    expect(page).to have_current_path(categories_path)
  end

  it "e não existe nenhuma categoria cadastrada" do
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(admin)
    visit root_path

    click_on 'Categorias'

    expect(page).to have_content('Categorias:')
    expect(page).to have_content('Nenhuma categoria cadastrada.')
    expect(page).to have_current_path(categories_path)
  end

  it "e clica no botão de cadastrar categorias" do
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(admin)

    visit root_path
    click_on 'Categorias'
    click_on 'Criar Categoria'

    expect(page).to have_current_path(new_category_path)
  end
end
