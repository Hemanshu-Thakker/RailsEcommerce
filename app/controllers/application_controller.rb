class ApplicationController < ActionController::Base
	include Pundit
	helper_method :current_user

	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
 
  private
    def user_not_authorized
      flash[:warning] = "You are not authorized to perform this action."
      redirect_to(request.referrer || user_items_path(current_user) || root_path)
    end
  
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end
  
end
