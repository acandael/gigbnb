class AddIdForRefundToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :id_for_refund, :string
  end
end
