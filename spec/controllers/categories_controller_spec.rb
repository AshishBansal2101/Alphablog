require 'rails_helper'
require 'signin_helper'

RSpec.describe "Categories", type: :request do

    context "::new category" do
    
        it "::get new category --success" do
          user=sign_in(true)
          get new_category_path
          expect(response).to be_successful
          expect(response.body).to include("Create")
        end
    
        it "::post create category successfully" do
          user=sign_in(true)
          expect{post '/categories', params: {
            category: {
              name: "travel"
            }
          }
        }.to change(Category, :count).by(1)
          follow_redirect!
          expect(response.body).to include("created")
        end
      
        it "::post create Category -invalid details" do
          user=sign_in
          expect{
            post '/categories', params: {
            category: {
                name: ""
                }
            }
          }.to change(Category, :count).by(0)
        end  
      end
    
    #   context "::edit article" do
    
    #     it "::get edit article" do
    #     #   user=sign_in
    #       article=new_article
    #       get edit_article_path(article)
    #       expect(response).to be_successful
    #       expect(response.body).to include("Update")
    #     end
      
    #     it "::post edit article successfully" do
    #       user=sign_in
    #       article=new_article
    #       patch "/articles/#{article.id}", params: {
    #         article: {
    #             title: "updated title",
    #             description: "hey there this is testing"
    #             }
    #       }
    #       expect(response).to redirect_to(article_path(article))
    #       follow_redirect!
    #       expect(response.body).to include("updated")
    #     end
    
    #   end
      
    #   context "::listing article" do
    
    #     it "::request list of all articles" do
    #       article=new_article
    #       get articles_path
    #       expect(response).to be_successful
    #       expect(response.body).to include("title")
    #     end
        
    #   end
      
      
    #   context "::show article page" do
    
    #       it "::get article page" do
    #         article=new_article
    #         get user_path(article)
    #         expect(response).to be_successful
    #         expect(response.body).to include("title")
    #       end
    
    #     end
    
    #   context "::destroy article" do
    
    #     it "::destroy  article" do
    #     #   user=sign_in(admin)
    #       article=new_article
    #       expect{
    #          delete "/articles/#{article.id}"
    #       }.to change(Article, :count).by(-1)
    #       expect(response).to redirect_to(articles_path)
    #     end

    #  end
    

end