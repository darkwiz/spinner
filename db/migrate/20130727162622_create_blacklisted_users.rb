class CreateBlacklistedUsers < ActiveRecord::Migration
  def up
  	create_table :blacklisted_users, id: false do |t|
     t.integer :blocker_id
     t.integer :user_id

     t.timestamps
  end
end

  def down
  	drop_table :blacklisted_users
  end
end
