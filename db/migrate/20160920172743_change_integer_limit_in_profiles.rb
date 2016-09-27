class ChangeIntegerLimitInProfiles < ActiveRecord::Migration
  def change
    change_column :profiles, :cc_number, :integer, limit: 8
  end
end
