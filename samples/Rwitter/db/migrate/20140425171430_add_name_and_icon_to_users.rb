class AddNameAndIconToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :icon, :string
  end
end
