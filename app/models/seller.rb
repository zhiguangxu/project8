class Seller < ActiveRecord::Base
	has_one :account, as: :accountable, dependent: :destroy
	has_many :products
end
