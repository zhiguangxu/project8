class BuyerPolicy
  attr_reader :current_account, :model

  def initialize(current_account, model)
    @current_account = current_account
    @buyer = model
  end

  def index?
    @current_account.Admin?
  end

  # def show?
  #   @current_account.Admin? or @current_account == @buyer.account
  # end

  def edit?
    @current_account.Admin? or @current_account == @buyer.account
  end

  def update?
    @current_account.Admin? or @current_account == @buyer.account
  end

  def destroy?
    return false if @current_account == @buyer.account
    @current_account.Admin?
  end

end