class AddFollowingToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users ,:follows , :int , array: true, default: []
  end
end
