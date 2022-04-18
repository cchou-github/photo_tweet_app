class UserBaseController < ApplicationController
  before_action :authorize_user

  def authorize_user
    redirect_to login_path if current_user.blank?
  end
end
