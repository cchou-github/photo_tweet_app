class Oauth2TweetsController < UserBaseController
  skip_before_action :verify_authenticity_token

  def callback
    access_token = Oauth2::Tweet::Client.new(code: params[:code]).request_access_token!
    session[:tweet_access_token] = access_token if access_token.present?
    return redirect_to photos_path
  rescue Oauth2::Tweet::Client::NoCodeError, Oauth2::Tweet::Client::RequestAccesstokenError => e
    logger.error e.message
    flash.alert = t(".errors.link_failed")
    return redirect_to photos_path
  end
end