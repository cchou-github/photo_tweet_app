class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  before_action :authorize

  # protected add to the user base controller
  # def authenticate_user!
  #   if user_signed_in?
  #     super
  #   else
  #     redirect_to root_path
  #   end
  # end

  
  private
  def authorize
    redirect_to login_path if current_user.blank?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
