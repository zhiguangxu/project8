class SellersController < ApplicationController
  before_action :set_seller, only: [:show, :edit, :update, :destroy]

  # GET /sellers
  # GET /sellers.json
  def index
    # @sellers = Seller.order(:name)

    # @hash = Gmaps4rails.build_markers(@sellers) do |seller, marker|
    #   marker.lat seller.latitude
    #   marker.lng seller.longitude
    #   marker.title seller.name
    # end

  end

  # GET /sellers/1
  # GET /sellers/1.json
  def show
    # @hash = Gmaps4rails.build_markers(@seller) do |seller, marker|
    #   marker.lat seller.latitude
    #   marker.lng seller.longitude
    #   marker.title seller.name
    # end
  end

  # GET /sellers/new
  def new
    # @seller = Seller.new
  end

  # GET /sellers/1/edit
  def edit
  end

  # POST /sellers
  # POST /sellers.json
  def create
    # @seller = Seller.new(seller_params)

    # respond_to do |format|
    #   if @seller.save
    #     format.html { redirect_to sellers_url, notice: "Seller #{@seller.name} was successfully created."}
    #     format.json { render action: 'show', status: :created, location: @seller }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @seller.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /sellers/1
  # PATCH/PUT /sellers/1.json
  def update
    respond_to do |format|
      if @seller.update(seller_params)
        format.html { redirect_to root_url, notice: "Seller #{@seller.name} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sellers/1
  # DELETE /sellers/1.json
  def destroy
    # begin
    #   @seller.destroy
    #   flash[:notice] = "Seller #{@seller.name} deleted"
    # rescue StandardError => e
    #   flash[:notice] = e.message
    # end
    # respond_to do |format|
    #   format.html { redirect_to sellers_url }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seller
      @seller = Seller.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seller_params
      params.require(:seller).permit(:name, :address)
    end
end