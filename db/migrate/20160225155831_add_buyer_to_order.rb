class AddBuyerToOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :buyer, index: true
  end
end
