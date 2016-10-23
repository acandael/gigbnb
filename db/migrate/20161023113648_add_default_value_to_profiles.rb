class AddDefaultValueToProfiles < ActiveRecord::Migration
  def change
    change_column_null :profiles, :is_host, false
  end
end
