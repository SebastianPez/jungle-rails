require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do

  # SETUP
  before :each do
    @spec_user = User.create!(
      first_name: 'Tom',
      last_name: 'Odell',
      email: 'testingspec@test.com',
      password: 'abc123',
      password_confirmation: 'abc123'
    )
  end

  scenario "User logs in with valid credentials and gets redirected to the home page." do

    #ACT
    visit "/login"
    fill_in id: 'login_email', with: "#{@spec_user.email}"
    fill_in id: 'login_password', with: "#{@spec_user.password}"
    click_button "Log In"
    expect(page).to have_content "Logged in as #{@spec_user.email}"
  end

end