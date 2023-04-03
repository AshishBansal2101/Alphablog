class RemoveFollowFollowerFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :follows
    remove_column :users, :followers
  end
end
