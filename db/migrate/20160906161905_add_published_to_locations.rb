class AddPublishedToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :published, :boolean, default: false
  end
end
