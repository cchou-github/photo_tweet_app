class ApplicationController < ActionController::Base  
  protect_from_forgery prepend: true
  
  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
