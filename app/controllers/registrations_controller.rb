class RegistrationsController < Devise::RegistrationsController

  def new
  	super
  end

  def create
  	super
  	@account.accountable = Buyer.new
  	@account.save!
  end

  def destroy
  	@account.accountable.destroy!
  	super
  end

end