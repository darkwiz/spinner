class AddIndexToBlacklistedUsers < ActiveRecord::Migration
  def change
  	change_column :blacklisted_users, :created_at, :datetime, :null => true, :default => nil
  	change_column :blacklisted_users, :updated_at, :datetime, :null => true, :default => nil
  	add_index :blacklisted_users, :blocker_id
    add_index :blacklisted_users, :user_id
    add_index :blacklisted_users, [:blocker_id, :user_id], unique: true
  end
end
