class RenameStateToRegion < ActiveRecord::Migration
  def change
    rename_column :addresses, :state, :region
  end
end
