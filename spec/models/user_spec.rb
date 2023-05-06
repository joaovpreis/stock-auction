require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Dá o cargo de Administrador ao usuário' do
    it "quando possui um email com domíno @leilaodogalpao.com.br" do
      user = User.new(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com.br', password:'password')

      user.valid?

      expect(user.admin?).to be(true)
    end
  end

  describe 'Não da cargo de Administrador ao usuário' do
    it "quando possui um email com domíno @leilaodogalpao.com" do
      user = User.new(name: 'João Guilherme', cpf:'89698395008', email:'joao@leilaodogalpao.com', password:'password')

      user.valid?

      expect(user.admin?).to be(false)
      expect(user.user?).to be(true)
    end

    it "quando possui um email com domíno @leilao.com.br" do
      user = User.new(name: 'João Guilherme', cpf:'89698395008', email:'paulo@dominio.com.br', password:'password')

      user.valid?

      expect(user.admin?).to be(false)
      expect(user.user?).to be(true)
    end

    it "quando possui um email com domíno @leilao.com.br" do
      user = User.new(name: 'João Guilherme', cpf:'89698395008', email:'joaoleilaodogalpao.com', password:'password')

      user.valid?

      expect(user.admin?).to be(false)
      expect(user.user?).to be(true)
    end
  end

  describe '#valid?' do
    it "o nome do usuário não pode estar em branco" do
      user = User.new(name: '', cpf:'89698395008', email:'joao@leilaodogalpao.com', password:'password')

      user.valid?

      expect(user.errors.include?(:name)).to be(true)
      expect(user.errors[:name]).to include(I18n.translate "errors.messages.blank")
    end

    it "o cpf do usuário não pode estar em branco" do
      user = User.new(name: 'João Guilherme', cpf:'', email:'joao@leilaodogalpao.com', password:'password')

      user.valid?

      expect(user.errors.include?(:cpf)).to be(true)
      expect(user.errors[:cpf]).to include(I18n.translate "errors.messages.blank")
    end

    it "o cpf do usuário não pode ser inválido" do
      user = User.new(name: 'João Guilherme', cpf:'72576767788', email:'joao@leilaodogalpao.com', password:'password')

      user.valid?

      expect(user.errors.include?(:cpf)).to be(true)
      expect(user.errors[:cpf]).to include(I18n.translate "errors.messages.invalid")
    end
    
    it "o cpf do usuário não pode ser composto pelo mesmo dígito" do
      user = User.new(name: 'João Guilherme', cpf:'11111111111', email:'joao@leilaodogalpao.com', password:'password')

      user.valid?

      expect(user.errors.include?(:cpf)).to be(true)
      expect(user.errors[:cpf]).to include(I18n.translate "errors.messages.invalid")
    end

    it "o cpf do usuário não deve ter mais de 11 dígitos" do
      user = User.new(name: 'João Guilherme', cpf:'896983950087', email:'joao@leilaodogalpao.com', password:'password')

      user.valid?

      expect(user.errors.include?(:cpf)).to be(true)
      expect(user.errors[:cpf]).to include(I18n.translate "errors.messages.invalid")
    end

    it "o cpf do usuário não deve ter menos de 11 dígitos" do
      user = User.new(name: 'João Guilherme', cpf:'9698395008', email:'joao@leilaodogalpao.com', password:'password')

      user.valid?

      expect(user.errors.include?(:cpf)).to be(true)
      expect(user.errors[:cpf]).to include(I18n.translate "errors.messages.invalid")
    end
  end
end
