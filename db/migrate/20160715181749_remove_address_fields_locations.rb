class RemoveAddressFieldsLocations < ActiveRecord::Migration
  def change
    remove_column :locations, :address
    remove_column :locations, :city
    remove_column :locations, :postal_code
    remove_column :locations, :state
    remove_column :locations, :country
  end
end
