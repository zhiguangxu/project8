class CreateBuyers < ActiveRecord::Migration
  def change
    create_table :buyers do |t|
      t.string :name
      t.string :address
      t.string :pay_type

      t.timestamps null: false
    end
  end
end
