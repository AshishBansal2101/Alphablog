require 'rails_helper'
require 'signin_helper'

RSpec.describe "sessions", type: :request do

    context "::new session" do
    
        it "::get new session page --success" do
          get login_path
          expect(response).to be_successful
          expect(response.body).to include("Login")
        end
        
        it "::post new session --success" do
            user=User.create(username:"ashish", email: "ashish@gmail.com", password: "12345678")
            post '/login' ,params: {
                session: {
                  email: "ashish@gmail.com",
                  password:"12345678"
                }
              }
            expect(response).to redirect_to(user)
            follow_redirect!
            expect(response.body).to include("Logged")
            expect(response).to be_successful
          end

          it "::post new session --invalid details" do
            post '/login' ,params: {
                session: {
                  email: "ashish@gmail.com",
                  password:"ghhhhhh"
                }
              }
            expect(response.body).to include("wrong")
          end

          it "::post new session --wrong password" do
            user=User.create(username:"ashish", email: "ashish@gmail.com", password: "12345678")
            post '/login' ,params: {
                session: {
                  email: "ashish@gmail.com",
                  password:"wrong password"
                }
              }
              expect(response.body).to include("wrong")
          end
    end

    context "destroy" do

        it "logout --success" do
        user=sign_in
        delete '/logout'
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include("Logged Out")
        end
        
    end
    

end