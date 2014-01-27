class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :decrement]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy, :decrement]
  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find(params[:product_id])
    product.popularity = product.popularity+1
    product.update_attributes(:popularity => product.popularity)

    @line_item = @cart.add_product(product.id)
    #@line_item = @cart.line_items.build(product: product)
    # Alternatively
    # @line_item = @cart.line_items.build
    # @line_item.product = product
    # or
    # @line_item = product.line_items.build
    # @line_item.cart = @cart
    # or
    # @line_item = product.line_items.build(cart: @cart)

    respond_to do |format|
      if @line_item.save
        session[:counter] = 0;

        format.html { redirect_to store_url }
        format.js { @current_item = @line_item }
        format.json { render action: 'show',
          status: :created, location: @line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH /line_items/1
  # PATCH /line_items/1.json
  def decrement
    @line_item = @cart.decrement_product_quantity(@line_item.id)
    product = @line_item.product
    product.popularity = product.popularity-1
    product.update_attributes(:popularity => product.popularity)
    
    if @line_item
      respond_to do |format|
        if @line_item.save
          format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
          format.js { @current_item = @line_item }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @line_item.errors, status: :unprocessable_entity }
        end
      end
    else
      if (@cart.line_items.size == 0)
        @cart.destroy
        session[:cart_id] = nil
      end
      respond_to do |format|
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.js { }
        format.json { head :no_content }
      end
    end

  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to line_items_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def line_item_params
    params.require(:line_item).permit(:product_id)
  end
end
