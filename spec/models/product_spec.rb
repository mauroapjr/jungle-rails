require 'rails_helper'

RSpec.describe Product, type: :model do
  
  describe 'Validations' do

    it "check if the name exist" do
      @category = Category.create(name: "Shrubs")
      @product = Product.create(quantity:12, price: 12, category: @category)
      expect(@product.name).to be_nil
      expect(@product.errors.messages[:name]).to include('can\'t be blank')
    end

    it "check if creates a new products with all fields" do
      @category = Category.create(name: "Shrubs")
      @product = Product.create(name: 'lilys', price: 20, quantity: 4, category: @category)
      expect(@product).to be_persisted
    end

    it "Check if there is a price" do
      @category = Category.create(name: "Shrubs")
      @product = Product.create(name: 'lilys', quantity: 4, category: @category)
      expect(@product.price).to be_nil
      expect(@product.errors.messages[:price]).to include('can\'t be blank')
    end

  end

end
