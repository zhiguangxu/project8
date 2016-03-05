class OrdersController < ApplicationController
  require 'will_paginate/array'

  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_account!, only: [:index, :show, :edit, :update, :destroy]

  def pundit_user
    current_account
  end

  # GET /orders
  # GET /orders.json
  def index
    # if (params[:buyer_id])
    #   @buyer = Buyer.find(params[:buyer_id])
    #   @orders = @buyer.orders
    # elsif (params[:seller_id])
    #   @seller = Seller.find(params[:seller_id])
    #   @products=@seller.products
    #   @all_orders = []
    #   @products.each do |product|
    #     @all_orders += product.orders
    #   end
    #   @all_orders = @all_orders.uniq {|order| order.id}
    #   # Convert array of objects to ActiveRecord::Relation
    #   @orders = Order.where(id: @all_orders.map(&:id))
    # else
    #   @orders = Order.all
    # end

    authorize Order 
    @orders = policy_scope(Order)
    @orders = @orders.order('created_at desc').paginate(page: params[:page],per_page: 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @products = @order.products
  end

  # GET /orders/new
  def new
    if @cart.line_items.empty?
      redirect_to store_url, notice: "Your cart is empty"
      return
    end
    @order = Order.new
    if current_account && current_account.accountable_type == "Buyer"
        @order.buyer = current_account.accountable
        @order.name = @order.buyer.name
        @order.address = @order.buyer.address
        @order.email = current_account.email
        @order.pay_type = @order.buyer
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)

    if current_account && current_account.accountable_type == "Buyer"
        @order.buyer = current_account.accountable
    end

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        
        OrderNotifier.received(@order).deliver 
        
        format.html { redirect_to store_url, notice: 'Thank you for your order.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type)
    end
end
