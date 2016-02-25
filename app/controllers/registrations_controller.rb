class RegistrationsController < Devise::RegistrationsController

  def new
  	super
  end

  def create
  	super
    if (params[:account][:type]=="Buyer")
  	 @account.accountable = Buyer.new
    else
      @account.accountable = Seller.new
    end
  	@account.save!
  end

  def destroy
  	@account.accountable.destroy!
  	super
  end

end