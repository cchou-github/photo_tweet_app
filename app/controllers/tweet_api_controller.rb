class TweetApiController < ApplicationController
  def create
    photo = Photo.find_by(id: params[:photo_id])
    access_token = session[:tweet_access_token]
    
    #TODO: raise_not_found 
    tweet_client = Api::TweetClient.new( #TODO: make async
      access_token: access_token, 
      photo_title: photo.title, 
      photo_url: url_for(photo.image_file)
    )
    tweet_client.post_tweet!
    
    return redirect_to photos_path
  rescue Api::TweetClient::TweetApiError, Api::TweetClient::NoAccessToken => e
    logger.error e.message
    flash.alert = t(".errors.tweet_failed")
    return redirect_to photos_path
  end
end
