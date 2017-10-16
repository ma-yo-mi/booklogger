class AddHandlenameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :handlename, :text
  end
end
