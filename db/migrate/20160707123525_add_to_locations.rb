class AddToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :created_at, :datetime
    add_column :locations, :updated_at, :datetime
  end
end
