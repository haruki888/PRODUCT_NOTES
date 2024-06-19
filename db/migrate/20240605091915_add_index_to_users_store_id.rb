class AddIndexToUsersStoreId < ActiveRecord::Migration[7.1]
  def change
    add_index :users, :store_id, unique: true
  end
end
