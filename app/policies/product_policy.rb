class ProductPolicy
  attr_reader :current_account, :model

  def initialize(current_account, model)
    @current_account = current_account
    @product = model
  end

  def index?
    @current_account.Admin? or @current_account.Seller?
  end

  def show?
    @current_account.Admin? or @current_account == @product.seller.account
  end

  def new?
    @current_account.Seller?
  end

  def create?
    @current_account.Seller?
  end

  def edit?
    @current_account.Admin? or @current_account == @product.seller.account
  end

  def update?
    @current_account.Admin? or @current_account == @product.seller.account
  end

  def destroy?
    @current_account.Admin? or @current_account == @product.seller.account
  end

  class Scope < Struct.new(:current_account, :model)
    def resolve
      if current_account.Admin?
        model.all
      else
        model.where(seller: current_account.accountable)
      end
    end
  end

end