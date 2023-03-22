require 'rails_helper'
require 'signin_helper'

RSpec.describe "pages", type: :request do
   context "::home" do
    it "::home page --sign in" do
        user=sign_in
        get root_path
        follow_redirect!
        expect(response.body).to include("Listing")
        expect(response).to be_successful
    end
    
    it "::home page --not signin" do
        get root_path
        expect(response.body).to include("Signup")
        expect(response).to be_successful
    end
    
   end

   context "::about" do

    it "::about page --success" do
        get '/about'
        expect(response.body).to include("about")
        expect(response).to be_successful
    end
   end
   
end