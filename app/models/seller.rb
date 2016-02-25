class Seller < ActiveRecord::Base
	has_one :account, as: :accountable
	has_many :products
end
