require 'rails_helper'

describe 'Usuário normal acessa a página de criação de categorias' do
  it "e é redirecionado para a página principal" do
    user = User.create!(name: 'Leonardo', cpf:'89698395008', email:'leonardo@gmail.com.br', password:'password')
    login_as(user)
    visit new_category_path

    expect(page).to have_current_path(root_path)
    expect(page).to have_content(I18n.translate('devise.autorization.not_authorized')) 
  end
  
end

describe "Administrador acessa a página de criação de categorias" do
  it 'e ve os campos corretamente' do
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(admin)
    visit new_category_path

    expect(page).to have_field('Nome')
    expect(page).to have_button('Criar Categoria')
  end

  it 'e cria uma nova categoria com sucesso' do
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(admin)
    visit new_category_path

    fill_in 'Nome',	with: 'Produtos Eletrônicos'

    click_button 'Criar Categoria'

    expect(page).to have_content('Categoria criada com sucesso.')
    expect(page).to have_current_path(category_path(Category.first.id))
    expect(Category.first.name).to eq('Produtos Eletrônicos')
  end

  it 'e tenta criar uma categoria já existente' do
    Category.create!(name: 'Produtos Eletrônicos')
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(admin)
    visit new_category_path

    fill_in 'Nome',	with: 'Produtos Eletrônicos'

    click_button 'Criar Categoria'

    expect(page).to have_content('Não foi possível criar a categoria.')
    expect(page).to have_field('Nome')
    expect(page).to have_button('Criar Categoria')
    expect(Category.where(name: 'Produtos Eletrônicos').size).to eq(1)
  end

  it 'e não insere nenhum nome para a categoria' do
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(admin)
    visit new_category_path

    fill_in 'Nome',	with: ''

    click_button 'Criar Categoria'

    expect(page).to have_content('Não foi possível criar a categoria.')
    expect(page).to have_field('Nome')
    expect(page).to have_button('Criar Categoria')
    expect(Category.all.empty?).to be(true)
  end
end
