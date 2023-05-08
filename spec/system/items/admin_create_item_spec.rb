require 'rails_helper'

describe "Administrador acessa a página de criação de items" do
  it "a partir da página inicial" do
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(admin)
    visit root_path

    click_on 'Criar Item'

    expect(page).to have_current_path(new_item_path)
  end

  it "e ve os campos corretamente" do
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(admin)
    visit new_item_path

    expect(page).to have_field('Nome')
    expect(page).to have_field('Descrição')
    expect(page).to have_field('Peso em gramas')
    expect(page).to have_field('Largura em centímetros')
    expect(page).to have_field('Altura em centímetros')
    expect(page).to have_field('Comprimento em centímetros')
    # expect(page).to have_select('Categoria')
    expect(page).to have_button('Criar Item')
  end

  it "e cria um novo item" do
    category = Category.create!(name: 'Produtos Eletrônicos')
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(admin)
    visit new_item_path

    fill_in('Nome', with: 'Macbook')
    fill_in('Descrição', with: 'Ótimo Notebook')
    fill_in('Peso em gramas', with: '600')
    fill_in('Largura em centímetros', with:'45')
    fill_in('Altura em centímetros', with:'5')
    fill_in('Comprimento em centímetros', with:'25')
    select category.name , from: 'item_category_id'
    click_button 'Criar Item'

    expect(page).to have_current_path(item_path(Item.last.id))
    expect(page).to have_content('Item criado com sucesso.')
    expect(page).to have_content('Macbook')
    expect(page).to have_content('Ótimo Notebook')
    expect(page).to have_content('600 g')
    expect(page).to have_content('45 cm')
    expect(page).to have_content('5 cm')
    expect(page).to have_content('25 cm')
    expect(Item.last.code.size).to eq(10)

  end
  
  it 'tenta criar um item com dados faltando' do
    category = Category.create!(name: 'Produtos Eletrônicos')
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(admin)
    visit new_item_path

    fill_in('Nome', with: 'Macbook')
    fill_in('Descrição', with: 'Ótimo Notebook')
    fill_in('Peso em gramas', with: '')
    fill_in('Largura em centímetros', with:'45')
    fill_in('Altura em centímetros', with:'Altura')
    fill_in('Comprimento em centímetros', with:'')
    select category.name , from: 'item_category_id'
    click_button 'Criar Item'


    expect(page).to have_content('Não foi possível criar o item.')
    expect(page).to have_field('Nome', with: 'Macbook')
    expect(page).to have_field('Descrição', with: 'Ótimo Notebook')
    expect(page).to have_field('Peso em gramas', with: '')
    expect(page).to have_field('Largura em centímetros', with:'45')
    expect(page).to have_field('Altura em centímetros', with:'Altura')
    expect(page).to have_field('Comprimento em centímetros', with:'')
    expect(page).to have_button('Criar Item')

  end
end
