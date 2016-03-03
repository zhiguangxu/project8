class BuyersController < ApplicationController
  before_action :set_buyer, only: [:show, :edit, :update, :destroy]
  
  def pundit_user
    current_account
  end

  # GET /buyers
  # GET /buyers.json
  def index
    # @buyers = Buyer.order(:name)

    # @hash = Gmaps4rails.build_markers(@buyers) do |buyer, marker|
    #   marker.lat buyer.latitude
    #   marker.lng buyer.longitude
    #   marker.title buyer.name
    # end
    #authorize Buyer
    #raise "not authorized" unless BuyerPolicy.new(current_account, Buyer).index?
    authorize Buyer
  end

  # GET /buyers/1
  # GET /buyers/1.json
  def show
    # @hash = Gmaps4rails.build_markers(@buyer) do |buyer, marker|
    #   marker.lat buyer.latitude
    #   marker.lng buyer.longitude
    #   marker.title buyer.name
    # end
    authorize @buyer
  end

  # GET /buyers/new
  def new
    # @buyer = Buyer.new
  end

  # GET /buyers/1/edit
  def edit
    #raise "not authorized" unless BuyerPolicy.new(current_account, @buyer).edit?
    authorize @buyer
  end

  # POST /buyers
  # POST /buyers.json
  def create
    # @buyer = Buyer.new(buyer_params)

    # respond_to do |format|
    #   if @buyer.save
    #     format.html { redirect_to buyers_url, notice: "Buyer #{@buyer.name} was successfully created."}
    #     format.json { render action: 'show', status: :created, location: @buyer }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @buyer.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /buyers/1
  # PATCH/PUT /buyers/1.json
  def update
    authorize @buyer
    respond_to do |format|
      if @buyer.update(buyer_params)
        format.html { redirect_to root_url, notice: "Buyer #{@buyer.name} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @buyer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buyers/1
  # DELETE /buyers/1.json
  def destroy
    # begin
    #   @buyer.destroy
    #   flash[:notice] = "Buyer #{@buyer.name} deleted"
    # rescue StandardError => e
    #   flash[:notice] = e.message
    # end
    # respond_to do |format|
    #   format.html { redirect_to buyers_url }
    #   format.json { head :no_content }
    # end
    authorize @buyer
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buyer
      @buyer = Buyer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def buyer_params
      params.require(:buyer).permit(:name, :address, :pay_type)
    end
end