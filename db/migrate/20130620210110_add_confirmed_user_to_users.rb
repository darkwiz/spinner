class AddConfirmedUserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirmed_user, :boolean, default: false
  end
end
