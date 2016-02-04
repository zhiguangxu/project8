#Order.transaction do (1..100).each do |i|
#  Order.create(name: "Customer #{i}", address: "#{i} Main Street", email: "customer-#{i}@example.com", pay_type: "Check")
#end end
Order.delete_all
99.times do |n|
	name = Faker::Name.name
	email = Faker::Internet.safe_email(name)
	address = Faker::Address.street_address
	pay_type = "Check"
	Order.create(name: name, 
				 email: email,
				 address: address,
				 pay_type: pay_type)
end
