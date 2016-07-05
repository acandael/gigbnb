class LocationsController < ApplicationController
  before_action :authenticate_member!
  def new
    @location = Location.new
    authorize @location
  end

  def show
    @location = Location.find(params[:id])
    authorize @location
  end

  def create
    @location = current_member.locations.build(location_params)
    authorize @location
    if @location.save
      redirect_to member_location_path(current_member, @location), notice: "Successfully created location."
    else 
      flash[:alert] = "Could not create location."
      render :new
    end
  end

  def edit
    @location = Location.find(params[:id])
    authorize @location
  end

  def update
    @location = Location.find(params[:id])
    if @location.update(location_params)
      redirect_to member_location_path(current_member, @location), notice: "Successfully updated location."
    else
      flash[:alert] = "Could not update location."
      render :edit
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    redirect_to member_profile_path(current_member, current_member.profile), notice: "Successfully deleted location."
  end

  private

  def location_params
    params.required(:location).permit(:member_id, :title, :description, :address, :city, :postal_code, :state, :country, :beds, :guests, :price)
  end
end
