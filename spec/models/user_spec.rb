require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(
      first_name: 'Valid',
      last_name: 'Test',
      email: 'testing@test.com',
      password: 'abc123',
      password_confirmation: 'abc123'
    )
  end

  describe 'Validations' do

    it 'user is valid with all forms filled out' do 
      expect(@user).to be_valid
    end
    
    it 'user is invalid without first_name present' do
      @user.first_name = nil
      expect(@user).to_not be_valid
    end

    it 'user is invalid without last_name present' do
      @user.last_name = nil
      expect(@user).to_not be_valid
    end

    it 'user is invalid without an email present' do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it 'user is invalid without a unique email' do
      @user.save
      @user2 = User.new(
        first_name: 'John',
        last_name: 'Travolta',
        email: 'test3@test.com',
        password: 'grease',
        password_confirmation: 'lightning'
      )
      expect(@user2).to_not be_valid
    end

    it 'user is invalid when password and password_confirmation do no match' do
      @user.password_confirmation = 'abc'
      expect(@user).to_not be_valid
    end

    it 'user is invalid when password length is less than 6 characters' do
      @user.password = 'abc12'
      expect(@user).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do

    it 'user should be signed in if they provide valid credentials' do
      @user.save
      expect(User.authenticate_with_credentials('testing@test.com', 'abc123')).to eq(@user)
    end

    it 'user should be able to include whitespace and still log in if credentials are valid' do
      @user.save
      expect(User.authenticate_with_credentials('   testing@test.com', 'abc123')).to eq(@user)
    end

    it 'user should be able to enter case-insensitive email and still log in if credentials are valid' do
      @user.save
      expect(User.authenticate_with_credentials('teStiNg@test.com', 'abc123')).to eq(@user)
    end
  end

end
