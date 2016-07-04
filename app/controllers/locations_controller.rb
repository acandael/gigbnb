class LocationsController < ApplicationController
  def new
    @location = Location.new
  end

  def show
    @location = Location.find(params[:id])
  end

  def create
    @location = Location.create(location_params)
    if @location.save
      redirect_to member_location_path(current_member, @location), notice: "Successfully created location."
    else 
      flash[:alert] = "Could not create location."
      render :new
    end
  end

  def edit
    @location = Location.find(params[:id])
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
