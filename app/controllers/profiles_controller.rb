class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def create
    @profile = current_member.create_profile(profile_params)
    if @profile.save
      redirect_to member_profile_path(current_member, @profile), notice: "Successfully created profile."
    else
      flash[:alert] = "Could not create profile."
      render :new 
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
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
