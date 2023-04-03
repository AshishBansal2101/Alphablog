class AddFollowersToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users ,:followers , :int , array: true, default: []
  end
end
