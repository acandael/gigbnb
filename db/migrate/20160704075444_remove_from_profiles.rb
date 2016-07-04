class RemoveFromProfiles < ActiveRecord::Migration
  def change
    remove_column :profiles, :type
  end
end
