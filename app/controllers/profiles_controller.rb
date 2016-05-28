class ProfilesController < ApplicationController
  def new
    @profile = current_member.build_profile
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def create
    @profile = Profile.create(profile_params)
    if @profile.save
      redirect_to member_profile_path(current_member, @profile), notice: "Successfully created profile."
    else
      flash[:alert] = "Could not create profile."
      render :new 
    end
  end

  private

  def profile_params
    params.required(:profile).permit(:member_id, :first_name, :last_name, :address, :city, :postal_code, :state, :birthday, :cc_number)
  end
end
