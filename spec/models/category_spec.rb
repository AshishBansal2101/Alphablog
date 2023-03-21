RSpec.describe Category, :type => :model do
    context "category model validation" do
        before(:each) do
            @category=Category.new(name: "sample")
          end
        it "must have a name" do
            @category.name=nil
            @category.save()
            expect(@category).to_not be_valid
        end

        it "name must be unique" do
            @category.save()
            @category2=Category.new(name: "sample")
            @category2.save()
            expect(@category2).to_not be_valid
        end
        
        it "name length should be greater than 3 character" do
            @category.name="ab"
            @category.save()
            expect(@category).to_not be_valid
          end
          
        it "name length should be smaller than 25 character" do
            @category.name="a"*26
            @category.save()
            expect(@category).to_not be_valid
        end

        it "valid category creation" do
            @category.name="valid"
            @category.save()
            expect(@category).to be_valid
        end
        
    end
end