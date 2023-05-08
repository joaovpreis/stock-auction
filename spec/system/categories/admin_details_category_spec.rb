require 'rails_helper'

describe 'Administrador acessa os detalhes de uma categoria' do
  it 'através da listagem de categorias' do
    category = Category.create!(name: 'Produtos Eletrônicos')
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(admin)
    visit categories_path

    click_on 'Produtos Eletrônicos'

    expect(page).to have_current_path(category_path(category.id))
    expect(page).to have_content('Nome:')
    expect(page).to have_content('Produtos Eletrônicos')
  end

  it 'e clica no botão para editar categoria' do
    category = Category.create!(name: 'Produtos Eletrônicos')
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(admin)
    visit category_path(category.id)

    click_on 'Editar Categoria'

    expect(page).to have_current_path(edit_category_path(category.id))
  end
end
