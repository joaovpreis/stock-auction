require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'gera o código de 10 caracters' do
    it "ao criar um novo item" do
      category = Category.create!(name: 'Produtos Eletrônicos')
      item = Item.new(name: 'Macbook',  description: 'Ótimo Notebook',  weight: 600,  width: 45,  height: 5,
                      length: 25,  category: category)
      allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('YSWEXTAO61')

      item.valid?

      expect(item.code).to eq('YSWEXTAO61') 
    end

    it "que deve ser único" do
      category = Category.create!(name: 'Produtos Eletrônicos')
      item = Item.new(name: 'Macbook',  description: 'Ótimo Notebook',  weight: 600,  width: 45,  height: 5,
                      length: 25,  category: category)
      item2 = Item.new(name: 'Notebook DELL',  description: 'Um dos melhores Notebooks',  weight: 800,  width: 50,
                      height: 5,length: 25,  category: category)


      item.valid?
      item2.valid?

      expect(item.code).not_to eq(item2.code) 
    end
  end
end

