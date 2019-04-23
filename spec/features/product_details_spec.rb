require 'rails_helper'

RSpec.feature "Visitor can view a specific product page", type: :feature, js: true do

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

  scenario "They click on a product's details button and go to that product's page" do

    #ACT
    visit root_path
    
    first("article.product").find_link("Details").click
    sleep 3

    save_screenshot "test_screenshot.png"

  end

  scenario "They click on a product's title and go to that product's page" do

    #ACT
    visit root_path
    
    first("article.product").find("header h4").click
    sleep 3

    save_screenshot "test_screenshot2.png"

  end

  scenario "They click on a product's picture and go to that product's page" do

    #ACT
    visit root_path
    
    first("article.product").find("header img").click
    sleep 3

    save_screenshot "test_screenshot3.png"

  end

end
