require 'rails_helper'

RSpec.feature "User adds item to their cart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "User clicks on the 'Add' button of a product and their cart is updated with that product." do

   #ACT
   visit root_path

   first("article.product").click_button('Add')
   sleep 3

   expect(page).to have_content "My Cart (1)"

   save_screenshot "add_to_cart.png"
  end
  
end
