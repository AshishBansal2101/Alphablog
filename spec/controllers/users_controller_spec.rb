require 'rails_helper'
require 'signin_helper'

RSpec.describe "Users", type: :request do

  context "::sign-up" do
    
    it "::get new user signup" do
      get signup_path
      expect(response).to be_successful
      expect(response.body).to include("Sign Up")
    end

    it "::post create user profile successfully" do
      expect{post '/users', params: {
        user: {
          username: 'ashish',
          email: 'ash@gmail.com',
          password:"12345678"
        }
      }
    }.to change(User, :count).by(1)
      expect(response).to redirect_to(articles_path)
      follow_redirect!
      expect(response.body).to include("Created")
    end
  
    it "::post create user profile -invalid details" do
      expect{
        post '/users', params: {
        user: {
          username: '',
          email: 'ash@gmail.com',
          password:"12345678"
         }
        }
      }.to change(User, :count).by(0)
    end  
  end

  context "::edit user" do
    before(:each) do
      @user2=User.create(username: "mytest", email: "testing@gmail.com", password: "mytesting")
    end

    it "::get edit user profile" do
      user=sign_in
      get edit_user_path(user)
      expect(response).to be_successful
      expect(response.body).to include("Update")
    end

    it "::get edit user profile --without login" do
      get edit_user_path(@user2)
      expect(response).not_to be_successful
    end

    it "::get edit user profile --admin" do
      user=sign_in(true)
      get edit_user_path(@user2)
      expect(response).to be_successful
      expect(response.body).to include("Update")
    end

    it "::get edit user profile --non admin and non current user" do
      user=sign_in()
      get edit_user_path(@user2)
      # expect(response).to be_successful
      expect(response).to redirect_to(@user2)
      follow_redirect!
      expect(response.body).to include("Own Profile")
    end
  
    it "::update patch user profile successfully" do
      user=sign_in
      patch "/users/#{user.id}", params: {
        user: {
          username: 'ashish updated',
          email: 'ash@gmail.com',
          password:"12345678"
  
        }
      }
      expect(response).to redirect_to(user_path(user))
      follow_redirect!
      expect(response.body).to include("updated")
    end


    it "::update patch user profile successfully --admin" do
      user=sign_in(true)
      patch "/users/#{@user2.id}", params: {
        user: {
          username: 'ashish updated',
          email: 'ash@gmail.com',
          password:"12345678"
  
        }
      }
      expect(response).to be_successful
    end

    it "::update patch user profile  --not admin not current user" do
      user=sign_in
      patch "/users/#{@user2.id}", params: {
        user: {
          username: 'ashish updated',
          email: 'ash@gmail.com',
          password:"12345678"
  
        }
      }
      expect(response).not_to be_successful
    end

    it "::update patch user profile  --not signin" do
      patch "/users/#{@user2.id}", params: {
        user: {
          username: 'ashish updated',
          email: 'ash@gmail.com',
          password:"12345678"
  
        }
      }
      expect(response).not_to be_successful
    end

  end
  
  context "::listing user" do

    it "::request list of all users --not sign in" do
      user = User.create(username: "Test", email: "ashish@gmail.com", password: "12345678")
      get users_path
      expect(response).to be_successful
      expect(response.body).to include("Test")
    end

    it "::request list of all users --admin" do
      user = User.create(username: "Test", email: "ashish@gmail.com", password: "12345678")
      user2=sign_in(true)
      get users_path
      expect(response).to be_successful
      expect(response.body).to include("Edit")
    end

    it "::request list of all users --sign-in" do
      user=sign_in(true)
      get users_path
      expect(response).to be_successful
      expect(response.body).to include("Edit")
    end
    
  end
  
  
  context "::show user profile" do

      it "::get show user profile --without login" do
        user = User.create(username: "Test", email: "ashish@gmail.com", password: "12345678")
        get user_path(user)
        expect(response).to be_successful
        expect(response.body).to include("Test")
      end

      it "::get show user profile --admin" do
        user = User.create(username: "Test", email: "ashish@gmail.com", password: "12345678")
        user2=sign_in(true)
        get user_path(user)
        expect(response).to be_successful
        expect(response.body).to include("Edit")
      end
      
      it "::get show user profile --with login" do
        user = sign_in
        get user_path(user)
        expect(response).to be_successful
        expect(response.body).to include("Edit")
      end

  end

  context "::destroy user" do

    it "::destroy  user profile--same user " do
      user=sign_in
      expect{
         delete "/users/#{user.id}"
      }.to change(User, :count).by(-1)
      expect(response).to redirect_to(articles_path)
      follow_redirect!
      expect(response.body).to include("Deleted")
    end

    it "::destroy  user profile--admin " do
      user=sign_in(true)
      user2=User.create(username: "mytest", email: "testing@gmail.com", password: "mytesting")
      expect{
         delete "/users/#{user2.id}"
      }.to change(User, :count).by(-1)
      expect(response).to redirect_to(articles_path)
      follow_redirect!
      expect(response.body).to include("Deleted")
    end

    it "::destroy  user profile--non-admin and non current user " do
      user=sign_in()
      user2=User.create(username: "mytest", email: "testing@gmail.com", password: "mytesting")
      expect{
         delete "/users/#{user2.id}"
      }.to change(User, :count).by(0)
       expect(response).to redirect_to(user2)
       follow_redirect!
       expect(response.body).to include("Own Profile")
    end

    it "::destroy  user profile--not signin " do
      user=User.create(username: "mytest", email: "testing@gmail.com", password: "mytesting")
      expect{
         delete "/users/#{user.id}"
      }.to change(User, :count).by(0)
      expect(response).not_to be_successful
    end
      
    end

end
