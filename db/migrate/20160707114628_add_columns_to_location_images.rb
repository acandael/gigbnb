class AddColumnsToLocationImages < ActiveRecord::Migration
  def change
    add_column :location_images, :picture_file_name, :string
    add_column :location_images, :picture_content_type, :string
    add_column :location_images, :picture_file_size, :integer
  end
end
