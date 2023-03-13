require 'rails_helper'

RSpec.describe Product, type: :model do
  
    describe 'Validations' do

      it "check if the name exist" do
        @category = Category.create(name: "Shrubs")
        @product = Product.create(name: 'lilys', price: 20, quantity: 4, category: @category)
        expect(@product).to be_persisted
    end
  end

end
