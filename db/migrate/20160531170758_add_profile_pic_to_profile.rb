class AddProfilePicToProfile < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.attachment :profile_pic
    end

    def self.down
      remove_attachment :profiles, :profile_pic
    end
  end
end
