class RemovePasswordAddEmail < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :password 
    add_column :users, :email, :string
  end
end
