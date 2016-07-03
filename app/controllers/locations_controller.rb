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
    end
  end

  private

  def location_params
    params.required(:location).permit(:member_id, :title, :description, :address, :city, :postal_code, :state, :country, :beds, :guests, :price)
  end
end
