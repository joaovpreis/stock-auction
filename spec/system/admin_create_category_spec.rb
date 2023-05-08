require 'rails_helper'

describe "Administrador acessa a página de criação de categorias" do
  it 'e ve os campos corretamente' do
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(admin)
    visit new_category_path

    expect(page).to have_field('Name')
    expect(page).to have_button('Criar Categoria')
  end

  it 'e cria uma nova categoria com sucesso' do
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(admin)
    visit new_category_path

    fill_in 'Name',	with: 'Produtos Eletrônicos'

    click_button 'Criar Categoria'

    expect(page).to have_content('Categoria criada com sucesso.')
    expect(page).to have_current_path(root_path)
    expect(Category.first.name).to eq('Produtos Eletrônicos')
  end

  it 'e tenta criar uma categoria já existente' do
    Category.create!(name: 'Produtos Eletrônicos')
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(admin)
    visit new_category_path

    fill_in 'Name',	with: 'Produtos Eletrônicos'

    click_button 'Criar Categoria'

    expect(page).to have_content('Não foi possível criar a categoria.')
    expect(page).to have_field('Name')
    expect(page).to have_button('Criar Categoria')
    expect(Category.where(name: 'Produtos Eletrônicos').size).to eq(1)
  end

  it 'e não insere nenhum nome para a categoria' do
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(admin)
    visit new_category_path

    fill_in 'Name',	with: ''

    click_button 'Criar Categoria'

    expect(page).to have_content('Não foi possível criar a categoria.')
    expect(page).to have_field('Name')
    expect(page).to have_button('Criar Categoria')
    expect(Category.all.empty?).to be(true)
  end
end
