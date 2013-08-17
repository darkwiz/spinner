class AddAttachmentMultimediaToSpins < ActiveRecord::Migration
  def self.up
    change_table :spins do |t|
      t.attachment :multimedia
    end
  end

  def self.down
    drop_attached_file :spins, :multimedia
  end
end
