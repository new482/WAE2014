class AddAvatarsToZsers < ActiveRecord::Migration
    def self.up
      add_attachment :zsers, :img_avatar
      add_attachment :zsers, :file_avatar
    end

    def self.down
      remove_attachment :zsers, :img_avatar
      remove_attachment :zsers, :file_avatar
    end
end
