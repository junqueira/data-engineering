class CostsController < ApplicationController
  before_action :set_cost, only: [:show, :edit, :update, :destroy]
  #respond_to :json

	def import
	  Cost.import(params[:file])
	  redirect_to root_url, notice: "Products imported."
	end

  # GET /costs
  # GET /costs.json
  def index
  	#respond_with PurchaseOrder.all
    @costs = Cost.all
  end

  # GET /costs/1
  # GET /costs/1.json
  def show
  end

  # GET /costs/new
  def new
    @cost = Cost.new
  end

  # GET /costs/1/edit
  def edit
  end

  # POST /costs
  # POST /costs.json
  def create
    @cost = Cost.new(cost_params)

    respond_to do |format|
      if @cost.save
        format.html { redirect_to @cost, notice: 'Cost was successfully created.' }
        format.json { render :show, status: :created, location: @cost }
      else
        format.html { render :new }
        format.json { render json: @cost.errors, status: :unprocessable_entity }
      end
    end

    begin
      total_amount_gross_revenue = DataImporter.import(params['purchases_file'].path)
      redirect_to action: index, notice: "File was successfully imported. Total amount gross revenue: #{view_context.number_to_currency(total_amount_gross_revenue)}"
    rescue Exception => e
      logger.error "!!! Import failed. Error: #{e.message}"
      redirect_to action: index, error: 'Import failed. Please make sure your file is properly formatted.'
    end

  end

  # PATCH/PUT /costs/1
  # PATCH/PUT /costs/1.json
  def update
    respond_to do |format|
      if @cost.update(cost_params)
        format.html { redirect_to @cost, notice: 'Cost was successfully updated.' }
        format.json { render :show, status: :ok, location: @cost }
      else
        format.html { render :edit }
        format.json { render json: @cost.errors, status: :unprocessable_entity }
      end
    end
  end

 def upload
    attachment = Attachment.new(params[:upload])
    attachment.create
    PurchaseOrder.import(attachment.file)
    render nothing: true, status: 200
  end

  # DELETE /costs/1
  # DELETE /costs/1.json
  def destroy
    @cost.destroy
    respond_to do |format|
      format.html { redirect_to costs_url, notice: 'Cost was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cost
      @cost = Cost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cost_params
      params.require(:cost).permit(:purchaser_name, :item_description, :item_price, :purchase_count, :merchant_address, :merchant_name)
    end
end
