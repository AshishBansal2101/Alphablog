require 'rails_helper'

RSpec.describe User, :type => :model do
    context "user model validation" do
      before(:each) do
        @user = User.new(username: 'sample',email: "samp@gmail.com",password: "12345678")
      end
      it "must have a username" do
        @user.username=""
        @user.save
        expect(@user).to_not be_valid
      end

      it "username must be unique" do
        @user.save
        @user2=User.new(username: "sample",email: "a@email.com", password: "12345678")
        @user2.save
        expect(@user2).to_not be_valid
      end

      it "email must be unique" do
        @user.save
        @user2=User.new(username: "sample2",email: "samp@gmail.com", password: "12345678")
        @user2.save
        expect(@user2).to_not be_valid
      end

      it "username length should be greater than 3 character" do
        @user.username="ab"
        @user.save
        expect(@user).to_not be_valid
      end
      
      it "username length should be smaller than 25 character" do
        @user.username='a'*26
        @user.save
        expect(@user).to_not be_valid
      end

      it "must have a email" do
        @user.email= ""
        @user.save
        expect(@user).to_not be_valid
      end

      it "email length should be smaller than 105 character" do
        @user.email="s"*107+"@gmail.com"
        @user.save
        expect(@user).to_not be_valid
      end

      it "must have a valid email" do
        @user.email="abc.com"
        @user.save
        expect(@user).to_not be_valid
      end

      it "user is valid" do
        @user.save
        expect(@user).to be_valid
      end

    end
    
    
end