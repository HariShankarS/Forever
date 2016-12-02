class AddAttachmentChitramToPhotographs < ActiveRecord::Migration
  def self.up
    change_table :photographs do |t|
      t.attachment :chitram
    end
  end

  def self.down
    remove_attachment :photographs, :chitram
  end
end
