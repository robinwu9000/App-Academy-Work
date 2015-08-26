class ChangeUsers < ActiveRecord::Migration
  def change
    remove_column :users, :email
    rename_column :users, :name, :username
  end
end
