class AddProfileFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :bio, :text
    add_column :users, :proPic, :string
    add_column :users, :mobileNum, :string
    add_column :users, :mem, :integer
    add_column :users, :greyStars, :integer
    add_column :users, :yellowStars, :integer
  end
end
