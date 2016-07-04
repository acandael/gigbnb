class AddIsHostToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :is_host, :bool
  end
end
