class RemoveInReplyFromSpins < ActiveRecord::Migration
  def up
    remove_column :spins, :in_reply_to
  end

  def down
    add_column :spins, :in_reply_to, :string
  end
end
