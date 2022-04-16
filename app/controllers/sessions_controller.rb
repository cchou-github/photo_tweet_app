class SessionsController < ApplicationController
  skip_before_action :authorize
  before_action :check_login_status, only: [:new, :create]
  before_action :validate_params_presence, only: :create

  def new
  end
  
  def create
    render "new" and return if @errors.present?
    user = User.find_by_account(params[:account])

    unless user && user.authenticate(params[:password])
      @errors << t(".errors.authentication_failed")
      render "new"
    else
      session[:user_id] = user.id
      redirect_to pictures_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private
  def check_login_status
    redirect_to pictures_path if current_user
  end

  def validate_params_presence #TODO: check in frontend
    @errors = [] 
    @errors << t(".errors.account_blank") if params[:account].blank?
    @errors << t(".errors.password_blank") if params[:password].blank?
  end
end
