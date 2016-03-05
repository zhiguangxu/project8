class OrderPolicy
  attr_reader :current_account, :model

  def initialize(current_account, model)
    @current_account = current_account
    @product = model
  end

  def index?
    true
  end

  def show?
    @current_account.Admin? or @current_account == @product.seller.account
  end

  def edit?
    @current_account.Admin? or @current_account == @product.seller.account
  end

  def update?
    @current_account.Admin? or @current_account == @product.seller.account
  end

  def destroy?
    return false if @current_account == @product.seller.account
    @current_account.Admin?
  end

  class Scope < Struct.new(:current_account, :model)
    def resolve
      if current_account.Admin?
        model.all
      elsif current_account.Buyer?
        model.where(buyer: current_account.accountable)
      else
        seller = Seller.find(current_account.accountable)
        products=seller.products
        all_orders = []
        products.each do |product|
          all_orders += product.orders
        end
        all_orders = all_orders.uniq {|order| order.id}
        Order.where(id: all_orders.map(&:id))
      end
    end
  end

end