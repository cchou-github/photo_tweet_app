class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_account(params[:account])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!" #TODO: i18n
    else
      flash.now.alert = "Email or password is invalid" #TODO: i18n
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!" #TODO: i18n
  end
end
