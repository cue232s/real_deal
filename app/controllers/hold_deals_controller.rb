class HoldDealsController < ApplicationController
  before_action :set_hold_deal, only: [:show, :edit, :update, :destroy]

  # GET /hold_deals
  # GET /hold_deals.json
  def index
    @hold_deals = HoldDeal.all
  end

  # GET /hold_deals/1
  # GET /hold_deals/1.json
  def show
  end

  # GET /hold_deals/new
  def new
    #find or create the property first
    @property = Property.find_or_create_by(address: params[:address], zipcode: params[:zipcode])
    #then create deal
    @deal = @property.hold_deals.create
    @upd = Rubillow::PropertyDetails.updated_property_details({ :zpid => @property.zillowId.to_i })
    @images = @upd.images
    flash[:notice] = "Sorry, No Property Found!" unless @property.zillowId
  end

  # GET /hold_deals/1/edit
  def edit
  end

  # POST /hold_deals
  # POST /hold_deals.json
  def create
    @hold_deal = HoldDeal.new(hold_deal_params)

    respond_to do |format|
      if @hold_deal.save
        format.html { redirect_to @hold_deal, notice: 'Hold deal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @hold_deal }
      else
        format.html { render action: 'new' }
        format.json { render json: @hold_deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hold_deals/1
  # PATCH/PUT /hold_deals/1.json
  def update
    respond_to do |format|
      if @hold_deal.update(hold_deal_params)
        format.html { redirect_to @hold_deal, notice: 'Hold deal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @hold_deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hold_deals/1
  # DELETE /hold_deals/1.json
  def destroy
    @hold_deal.destroy
    respond_to do |format|
      format.html { redirect_to hold_deals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hold_deal
      @hold_deal = HoldDeal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hold_deal_params
      params[:hold_deal]
    end
end
