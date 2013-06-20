class AddUserConfirmToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_confirm_token, :string
    add_column :users, :user_confirm_sent_at, :datetime
  end
end
