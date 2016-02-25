class Buyer < ActiveRecord::Base
	has_one :account, as: :accountable
	has_many :orders
end
