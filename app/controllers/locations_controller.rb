class LocationsController < ApplicationController
  before_action :authenticate_member!

  def add_images
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
    @location.build_address
    authorize @location
  end

  def show
    @location = Location.find(params[:id])
    @profile = current_member.profile
    @coordinates = {lng: @location.address.longitude, lat: @location.address.latitude}
    authorize @location
  end

  def calendar
    @location = Location.find(params[:id])
  end

  def create
    @location = current_member.locations.build(location_params)
    authorize @location

    respond_to do |format|
      if @location.save
        format.html { redirect_to add_images_location_path(@location), notice: "Successfully created location." }
      else 
        flash[:alert] = "Could not create location."
        format.html {render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @location = Location.find(params[:id])
    authorize @location
  end

  def update
    @location = Location.find(params[:id])
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to member_location_path(current_member, @location), notice: "Successfully updated location." }
        format.json { render :show, status: :ok, location: @location }
      else
        flash[:alert] = "Could not update location."
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    respond_to do |format|
      format.html { redirect_to member_profile_path(current_member, current_member.profile), notice: "Successfully deleted location." }
      format.json { head :no_content }
    end
  end


  def add_available_dates
    @location = Location.find(params[:id])
    if params[:start_date] != "" && params[:end_date] != ""
    @location.create_available_dates(params[:start_date],
    params[:end_date])
    redirect_to calendar_location_path(@location), notice: "Successfully
    added available dates"
    else
      render calendar_location(@path), notice: "The available date could not be added"
    end
  end

  private

  def location_params
    params.required(:location).permit(:member_id, :title, :description, :beds, :guests, :price, address_attributes: [:id, :street, :city, :postal_code, :region, :country, :longitude, :latitude], location_images_attributes: [:id, :picture, :picture_order, :_destroy, :location_id])
  end
end
