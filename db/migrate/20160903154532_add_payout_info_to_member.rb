class AddPayoutInfoToMember < ActiveRecord::Migration
  def change
    add_column :members, :stripe_access_token, :string
    add_column :members, :stripe_refresh_token, :string
    add_column :members, :stripe_publishable_key, :string
    add_column :members, :stripe_user_id, :string
    add_column :members, :provider, :string
  end
end
