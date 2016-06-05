class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception

  alias_method :current_user, :current_member
  rescue_from Pundit::NotAuthorizedError, with: :member_not_authorized

  private
   def member_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
   end
end
