class LocationsController < ApplicationController
  before_action :set_location, only: [
      :show, :edit, :update, 
      :destroy, :add_images, :calendar,
      :add_available_dates]


  def add_images   
  end
  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
     
    # @coordinates = {lng: @location.longitude, lat: @location.latitude}
    @coordinates = {lng: @location.longitude, lat: @location.latitude, radius: 800}
   
    # @circles_json = '[
    #  {"lng": -122.214897, "lat": 37.772323, "radius": 1000000},
    #  //you can add whatever customization within the hash
    #  {"lng": 122.214897, "lat": 37.772323, "radius": 1000000, "strokeColor": "#FF0000"}
    # ]'
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  def calendar    
  end

  def add_available_dates
    @location.create_available_dates(params[:start_date], params[:end_date])
    redirect_to calendar_location_path(location), notice: "Successfully added available dates"
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to add_images_location_path(@location), notice: 'Location was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(
        :description, 
        :address_1, :address_2, :city, :region, 
        :country, :zip,
        location_images_attributes: [:id, :picture, :picture_order, :_destroy, :location_id]        
      )
    end
end
