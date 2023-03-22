require 'rails_helper'
require 'signin_helper'

RSpec.describe "Categories", type: :request do
  before (:each) do
    @category=Category.create(name: "testtt")
  end
    context "::new category" do
    
        it "::get new category --success -admin" do
          user=sign_in(true)
          get new_category_path
          expect(response).to be_successful
          expect(response.body).to include("Create")
        end

        it "::get new category --non admin" do
          user=sign_in
          get new_category_path
          expect(response).not_to be_successful
        end

        it "::get new category --non signin" do
          get new_category_path
          expect(response).not_to be_successful
        end
    
        it "::post create category successfully --admin" do
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

        it "::post create category  --non admin" do
          user=sign_in
          expect{post '/categories', params: {
            category: {
              name: "travel"
            }
          }
        }.to change(Category, :count).by(0)
          expect(response).not_to be_successful
        end

        it "::post create category  --non sign in" do
          expect{post '/categories', params: {
            category: {
              name: "travel"
            }
          }
        }.to change(Category, :count).by(0)
          expect(response).not_to be_successful
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
    
      context "::edit article" do
        

        it "::get edit categories" do
          user=sign_in(true)
          
          get edit_category_path(@category)
          expect(response).to be_successful
          expect(response.body).to include("Update")
        end
      
        it "::post edit category successfully --admin" do
          user=sign_in(true)
          patch "/categories/#{@category.id}", params: {
            category: {
                name: "updated"
                }
          }
          expect(response).to redirect_to(@category)
          follow_redirect!
          expect(response).to be_successful  
          expect(response.body).to include("updated")
        end

        it "::post edit category successfully --non admin" do
          user=sign_in
          patch "/categories/#{@category.id}", params: {
            category: {
                name: "updated"
                }
          }
          expect(response).not_to be_successful
        end

        it "::post edit category successfully --non signin" do
          user=sign_in
          patch "/categories/#{@category.id}", params: {
            category: {
                name: "updated"
                }
          }
          expect(response).not_to be_successful
        end
    
      end
      
      context "::listing category" do
    
        it "::request list of all categories --non signin" do
          get categories_path
          expect(response).to be_successful
        end

        it "::request list of all categories --signin" do
          user=sign_in
          get categories_path
          expect(response).to be_successful
        end

        it "::request list of all categories --admin" do
          user=sign_in(true)
          get categories_path
          expect(response).to be_successful
        end
        
      end
      
      
      context "::show category page" do
    
          it "::show category page --non signin" do
            get category_path(@category)
            expect(response).to be_successful
          end

          it "::show category page --signin" do
            user=sign_in
            get category_path(@category)
            expect(response).to be_successful
          end

          it "::show category page --admin" do
            user=sign_in(true)
            get category_path(@category)
            expect(response).to be_successful
          end
    
        end
    
      context "::destroy category" do
    
        it "::destroy  category --admin" do
          user=sign_in(true)
          expect{
             delete "/categories/#{@category.id}"
          }.to change(Category, :count).by(-1)

          expect(response).to redirect_to(categories_path)
          follow_redirect!
          expect(response).to be_successful
        end

        it "::destroy  category --non admin" do
          user=sign_in
          expect{
             delete "/categories/#{@category.id}"
          }.to change(Category, :count).by(0)
          expect(response).not_to be_successful
        end

        it "::destroy  category --non signin" do
          expect{
             delete "/categories/#{@category.id}"
          }.to change(Category, :count).by(0)
          expect(response).not_to be_successful
        end

     end
    

end