class ProfilesController < ApplicationController
  before_action :authenticate_member!
  def new
    @profile = Profile.new
    authorize @profile
  end

  def show
    @profile = Profile.find(params[:id])
    authorize @profile
  end

  def create
    @profile = current_member.create_profile(profile_params)
    authorize @profile
    if @profile.save
      redirect_to member_profile_path(current_member, @profile), notice: "Successfully created profile."
    else
      flash[:alert] = "Could not create profile."
      render :new 
    end
  end

  def edit
    @profile = Profile.find(params[:id])
    authorize @profile
  end

  def update
    @profile = Profile.find(params[:id])
    authorize @profile
    if @profile.update(profile_params)
      redirect_to member_profile_path(current_member, @profile), notice: "Successfully updated profile."
    else
      flash[:alert] = "Could not update profile."
      render :edit
    end
  end

  private

  def profile_params
    params.required(:profile).permit(:first_name, :last_name, :address, :city, :postal_code, :state, :birthday, :cc_number, :member_id, :profile_pic)
  end
end
