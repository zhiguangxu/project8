class RegistrationsController < Devise::RegistrationsController

  def new
  	super
  end

  def create
  	super
    if (params[:account][:role]=="Buyer")
  	  @account.accountable = Buyer.new
    elsif (params[:account][:role]=="Seller")
      @account.accountable = Seller.new
    else
      
    end
  	@account.save!
  end

  def destroy
  	@account.accountable.destroy!
  	super
  end

end