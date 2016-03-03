class SellerPolicy
  attr_reader :current_account, :model

  def initialize(current_account, model)
    @current_account = current_account
    @seller = model
  end

  def index?
    @current_account.Admin?
  end

  def show?
    @current_account.Admin? or @current_account == @seller.account
  end

  def edit?
    @current_account.Admin? or @current_account == @seller.account
  end

  def update?
    @current_account.Admin? or @current_account == @seller.account
  end

  def destroy?
    return false if @current_account == @seller.account
    @current_account.Admin?
  end

end