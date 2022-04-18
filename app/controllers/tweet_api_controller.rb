class TweetApiController < UserBaseController
  before_action :check_session_token
  before_action :set_photo

  def tweet
    access_token = session[:tweet_access_token]
    
    tweet_client = Api::Tweet::Client.new( # TODO: make async
      access_token: access_token, 
      photo_title: @photo.title, 
      photo_url: url_for(@photo.image_file)
    )
    tweet_client.post_tweet! #TODO: Net::ReadTimeout error handling
    
    return redirect_to photos_path, notice: t(".tweet_success")
  rescue Api::Tweet::Errors::TweetApiError, Api::Tweet::Errors::NoAccessTokenError => e
    logger.error e.message
    return redirect_to photos_path, alert: t(".errors.tweet_failed")
  end

  private
  def check_session_token
    redirect_to photos_path, alert: t(".errors.tweet_failed") if session[:tweet_access_token].blank?
  end

  def set_photo
    @photo = current_user.photos.find_by(id: params[:photo_id])
    not_found if @photo.nil?
  end
end
