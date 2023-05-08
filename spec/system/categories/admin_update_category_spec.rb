require 'rails_helper'

describe "Administrador acessa o formulário de edição de categoria" do
  it 'e ve os campos corretamente' do
    category = Category.create!(name: 'Produtos Eletrônicos')
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(admin)
    visit edit_category_path(category.id)

    expect(page).to have_field('Nome', with: 'Produtos Eletrônicos')
    expect(page).to have_button('Atualizar Categoria')
  end

  it 'e atualiza categoria' do
    category = Category.create!(name: 'Produtos Eletrônicos')
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(admin)
    visit edit_category_path(category.id)

    fill_in('Nome', with: 'Produtos de Tecnologia')
    click_on 'Atualizar Categoria'

    expect(page).to have_current_path(category_path(category.id))
    expect(page).to have_content('Categoria atualizada com sucesso.')  
    expect(page).to have_content('Nome:')
    expect(page).to have_content('Produtos de Tecnologia')
    expect(page).not_to have_content('Produtos Eletrônicos')
  end

  it 'e tenta atualizar com o nome de uma categoria já existente' do
    category = Category.create!(name: 'Produtos Eletrônicos')
    Category.create!(name: 'Produtos de Limpeza')
    admin = User.create!(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')
    login_as(admin)
    visit edit_category_path(category.id)

    fill_in('Nome', with: 'Produtos de Limpeza')
    click_on 'Atualizar Categoria'

    expect(page).to have_current_path(category_path(category.id))
    expect(page).to have_content('Não foi possível atualizar a categoria.')  
    expect(page).to have_field('Nome', with: 'Produtos de Limpeza')
  end
end
