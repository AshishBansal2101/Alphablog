require 'rails_helper'
require 'signin_helper'

RSpec.describe "Articles", type: :request do

  before(:each) do
    @user=User.create(username: "ashish123", email: "testing@gmail.com", password: "qwerty123")
    @article=Article.new(title: "myarticle", description: "this is description")
    @user.articles<<@article
  end

    context "::new article" do
    
        it "::get new article --success" do
          user=sign_in
          get new_article_path
          expect(response).to be_successful
          expect(response.body).to include("Create")
        end

        it "::get new article --non signin" do
          get new_article_path
          expect(response).not_to be_successful
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

        it "::post create user article successfully --non sign in" do
          post '/articles', params: {
            article: {
              title: "this is title",
              description: "hey there this is testing"
            }
          }
        expect(response).not_to be_successful
        end
      
        it "::post create user article -invalid details" do
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
          article=new_article
          get edit_article_path(article)
          expect(response).to be_successful
          expect(response.body).to include("Update")
        end

        it "::get edit article --admin" do
            user=sign_in(true)
            get edit_article_path(@article)
            expect(response).to be_successful
            expect(response.body).to include("Update")
        end

        it "::get edit article --non admin and non current user" do
          user=sign_in
          get edit_article_path(@article)
          expect(response).not_to be_successful
        end

        it "::get edit article --non signin" do
          get edit_article_path(@article)
          expect(response).not_to be_successful
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

        it "::post edit article --admin" do
          user2=sign_in(true)
          
          patch "/articles/#{@article.id}", params: {
            article: {
                title: "hey there",
                description: "hey there this is testing"
                }
          }
          expect(response).to redirect_to(article_path(@article))
          follow_redirect!
          expect(response.body).to include("updated")
        end

        it "::post edit article --not admin and not current user" do
          user2=sign_in()
          
          patch "/articles/#{@article.id}", params: {
            article: {
                title: "",
                description: "hey there this is testing"
                }
          }
          expect(response).not_to be_successful
      end
    end
      
      context "::listing article" do
    
        it "::article list of all articles" do
          article=new_article
          get articles_path
          expect(response).to be_successful
          expect(response.body).to include("title")
        end

        it ": article list--not signin" do
          get articles_path
          expect(response).not_to be_successful
        end
        
      end
      
      
      context "::show article page" do
    
          it "::get article page" do
            article=new_article
            get user_path(article)
            expect(response).to be_successful
            expect(response.body).to include("title")
          end

          it "::get  article page --not signin" do
            get user_path(@article)
            expect(response).to be_successful
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
            
            user=sign_in(true)
            expect{
               delete "/articles/#{@article.id}"
            }.to change(Article, :count).by(-1)
            expect(response).to redirect_to(articles_path)
          end

          it "::destroy  article --not admin and non current user" do
            
            user2=sign_in
            expect{
               delete "/articles/#{@article.id}"
            }.to change(Article, :count).by(0)
            expect(response).not_to be_successful
          end

          it "::destroy  article --not signin" do
            expect{
               delete "/articles/#{@article.id}"
            }.to change(Article, :count).by(0)
            expect(response).not_to be_successful
          end
     end
    

end