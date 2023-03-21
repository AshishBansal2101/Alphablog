require 'rails_helper'
require 'signin_helper'

RSpec.describe "Articles", type: :request do

    context "::new article" do
    
        it "::get new article --success" do
          user=sign_in
          get new_article_path
          expect(response).to be_successful
          expect(response.body).to include("Create")
        end
    
        it "::post create user article successfully" do
          user=sign_in
          expect{post '/articles', params: {
            article: {
              title: "this is title",
              description: "hey there this is testing"
            }
          }
        }.to change(Article, :count).by(1)
          follow_redirect!
          expect(response.body).to include("Created")
        end
      
        it "::post create user profile -invalid details" do
          user=sign_in
          expect{
            post '/articles', params: {
            article: {
                title: "",
                description: "hey there this is testing"
                }
            }
          }.to change(User, :count).by(0)
        end  
      end
    
      context "::edit article" do
    
        it "::get edit article" do
        #   user=sign_in
          article=new_article
          get edit_article_path(article)
          expect(response).to be_successful
          expect(response.body).to include("Update")
        end
      
        it "::post edit article successfully" do
          user=sign_in
          article=new_article
          patch "/articles/#{article.id}", params: {
            article: {
                title: "updated title",
                description: "hey there this is testing"
                }
          }
          expect(response).to redirect_to(article_path(article))
          follow_redirect!
          expect(response.body).to include("updated")
        end
    
      end
      
      context "::listing article" do
    
        it "::request list of all articles" do
          article=new_article
          get articles_path
          expect(response).to be_successful
          expect(response.body).to include("title")
        end
        
      end
      
      
      context "::show article page" do
    
          it "::get article page" do
            article=new_article
            get user_path(article)
            expect(response).to be_successful
            expect(response.body).to include("title")
          end
    
        end
    
      context "::destroy article" do

    
        it "::destroy  article" do
          article=new_article
          expect{
             delete "/articles/#{article.id}"
          }.to change(Article, :count).by(-1)
          expect(response).to redirect_to(articles_path)
        end

        it "::destroy  article --admin" do
            
            article=new_article

            post '/users', params: {
              user: {
                username: 'ashish2',
                email: 'ash2@gmail.com',
                password:"123458888",
                admin: "true"
               }
              }

            expect{
               delete "/articles/#{article.id}"
            }.to change(Article, :count).by(-1)
            expect(response).to redirect_to(articles_path)
          end

          it "::destroy  article --not admin and non current user" do
            
            article=new_article

            post '/users', params: {
              user: {
                username: 'ashish2',
                email: 'ash2@gmail.com',
                password:"123458888"
               }
              }
              
            expect{
               delete "/articles/#{article.id}"
            }.to change(Article, :count).by(0)
            expect(response).not_to be_successful
          end

     end
    

end