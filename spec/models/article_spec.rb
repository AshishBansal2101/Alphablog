require 'rails_helper'

RSpec.describe Article, :type => :model do
    context "Article model validation" do
      before(:each) do
        @user = User.new(username: 'sample',email: "samp@gmail.com",password: "hey there this is testing")
        @user.save()
      end
      
      it "must have a title" do
        article = Article.new(title: '',description: "hey there this is testing")
        article.user=@user
        expect(article).to_not be_valid
      end

      it "must have a description" do
        article = Article.new(title: 'sample',description: "")
        article.user=@user
        expect(article).to_not be_valid
      end

      it "title length should be greater than 6 character" do
        article = Article.new(title: 'abcde',description: "hey there this is testing")
        article.user=@user
        expect(article).to_not be_valid
      end
      
      it "article length should be smaller than 100 character" do
        article = Article.new(title: 'a'*101,description: "hey there this is testing")
        article.user=@user
        expect(article).to_not be_valid
      end

      it "description length should be greater than 10 character" do
        article = Article.new(title: 'abcdehj',description: "hey")
        article.user=@user
        expect(article).to_not be_valid
      end
      
      it "description length should be smaller than 300 character" do
        article = Article.new(title: 'sample',description: "h"*301)
        article.user=@user
        expect(article).to_not be_valid
      end

      it "Article is valid" do
        article = Article.new(title: 'sample',description: "hey this is sample testing")
        article.user=@user
        expect(article).to be_valid
      end

    end
    
    
end