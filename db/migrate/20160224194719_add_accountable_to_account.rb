class AddAccountableToAccount < ActiveRecord::Migration
  def change
    add_reference :accounts, :accountable, polymorphic: true, index: true
  end
end
