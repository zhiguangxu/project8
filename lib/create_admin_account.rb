Account.transaction do
  Account.delete_all
  Account.create( :email => 'admin@depot.com', :password => 'changeme', :password_confirmation => 'changeme',
  				  :role => "Admin")
end