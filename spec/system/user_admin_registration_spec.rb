# require 'rails_helper'

# describe "Visitante acessa a tela de cadastro" do
#   it "e ve os campos corretos" do
#      visit new_user_registration_path

#     expect(page).to have_content('Cadastro de Usuário')
#     expect(page).to have_field('Nome')
#     expect(page).to have_field('CPF')
#     expect(page).to have_field('E-mail')
#     expect(page).to have_field('Senha')
#     expect(page).to have_field('Confirmação da Senha')
#     expect(page).to have_button('Cadastrar') 
#   end
  
#   it "e se cadastra como usuário administrador" do
#     visit new_user_registration_path

#     fill_in "Nome",	with: 'João Guilherme'
#     fill_in "CPF",	with: '89698395008'
#     fill_in "'E-mail",	with: '89698395008'
#     fill_in "Senha",	with: '1234567890'
#     fill_in "Nome",	with: '1234567890' 
#     fill_in "Confirmação da Senha",	with: '1234567890'

#     click_on 'Cadastrar'

#     admin_user = User.find_by(cpf: '89698395008')
    
#     expect(admin_user.name).to eq('João Guilherme')
#     expect(admin_user.cpf).to eq('89698395008')
#     expect(admin_user.password).to eq('')
#     expect(admin_user.name).to eq('')
#  end
  
# end
