class Oauth2TweetsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authorize

  def callback
    access_token = Oauth2::TweetClient.new(code: params[:code]).request_access_token!
    session[:tweet_access_token] = access_token if access_token.present?
    byebug
    return redirect_to photos_path
  rescue Oauth2::TweetClient::NoCodeError, Oauth2::TweetClient::RequestAccesstokenError => e
    logger.error e.message
    flash.alert = t(".errors.link_failed")
    return redirect_to photos_path
  end
end