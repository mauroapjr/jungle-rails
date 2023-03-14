require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do

    it "Check if the user password insert confirmation password" do
      @user = User.create(name: "Test", last_name: "Test", email: "test@test.com", password: "testing", password_confirmation: nil)
      expect(@user.password_confirmation).to be_nil
    end

    it "Check if user has a valid password" do 
      @user = User.create(name: "Test", last_name: "Test", email: "test@test.com", password: "", password_confirmation: "test")  
      expect(@user).to_not be_valid 
      expect(@user.errors.full_messages).to include("Password can't be blank") 
    end

    it "Check the presence of first name" do 
      @user = User.create(id: nil, name: nil, last_name: "Test", email: "test@test.com", password: "testing", password_confirmation: "testing")
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages[0]).to eq("Name can't be blank")
    end 

    it "Check the presence of last name" do 
      @user = User.create(name: "test", last_name: nil, email: "test@test.com", password: "testing", password_confirmation: "testing")
      expect(@user).not_to be_valid 
      expect(@user.errors.full_messages[0]).to eq("Last name can't be blank")
    end 

    it "Check the presence of email" do 
      @user = User.create(name: "Test", last_name: "Test", email: "", password: "testing", password_confirmation: "testing")
      expect(@user).not_to be_valid 
      expect(@user.errors.full_messages[0]).to eq("Email can't be blank")
    end 

    it "Check if user passwords does match" do
      @user = User.create(name: "Test", last_name: "Test", email: "test@test.com", password: "testing123", password_confirmation: "testing")
      expect(@user).not_to be_valid 
      expect(@user.errors.full_messages[0]).to eq("Password confirmation doesn't match Password")
    end

    it "Check if passwords have minimum 6 charaters" do 
      @user = User.create(name: "Test", last_name: "Test", email: "test@test.com", password: "test", password_confirmation: "testing")
      expect(@user).not_to be_valid 
      expect(@user.errors.full_messages[0]).to eq("Password confirmation doesn't match Password")
    end

    it "emails should be unique case sensitive " do 
      @user = User.create(name: "Test", last_name: "Test", email: "test@test.com", password: "testing", password_confirmation: "testing")
      @user.save
      @user2 =User.create(name: "Test", last_name: "Test", email: "test@test.COM", password: "testing", password_confirmation: "testing")
      expect(@user2).not_to be_valid 
      expect(@user2.errors.full_messages[0]).to eq("Email has already been taken")
    end

    it "emails should be unique NOT case sensitive " do 
      @user = User.create(name: "Test", last_name: "Test", email: "test@test.com", password: "testing", password_confirmation: "testing")
      @user.save
      @user2 = User.create(name: "Test2", last_name: "Test2", email: "test@test.com", password: "testing2", password_confirmation: "testing2")
      expect(@user2).not_to be_valid 
      expect(@user2.errors.full_messages[0]).to eq("Email has already been taken")
    end
  
  describe '.authenticate_with_credentials' do 
   
      it "It should authenticate with credentials" do 
        @user = User.create(name: "Test", last_name: "Test", email: "test@test.com", password: "testing", password_confirmation: "testing")
        @user.save 
        expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq(@user)
      end

      it "It should not authenticate with invalid email" do 
        @user = User.create(name: "Test", last_name: "Test", email: "test@test.com", password: "testing", password_confirmation: "testing")
        @user.save 
        expect(User.authenticate_with_credentials("wrong@test.com", @user.password)).to be_nil
      end

      it "It should not authenticate with invalid password" do
        @user = User.create(name: "Test", last_name: "Test", email: "test@test.com", password: "testing", password_confirmation: "testing")
        @user.save 
        expect(User.authenticate_with_credentials(@user.email, "wrongpassword")).to be_nil
      end

      it "It should authenticate with extra spaces before email" do 
        @user = User.create(name: "Test", last_name: "Test", email: "test@test.com", password: "testing", password_confirmation: "testing")
        @user.save 
        expect(User.authenticate_with_credentials("   test@test.com",@user.password)).to eq(@user)
      end

      it "It should authenticate with wrong case email" do 
        @user = User.create(name: "Test", last_name: "Test", email: "test@test.com", password: "testing", password_confirmation: "testing")
        @user.save 
        expect(User.authenticate_with_credentials("test@TeST.com",@user.password)).to eq(@user)
      end
    end 
  end
end




































