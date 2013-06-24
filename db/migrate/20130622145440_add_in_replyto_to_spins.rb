class AddInReplytoToSpins < ActiveRecord::Migration
  def change
    add_column :spins, :in_reply_to, :string
  end
    add_index :users, :username, unique: true
end
