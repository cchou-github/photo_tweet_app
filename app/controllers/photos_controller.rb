class PhotosController < UserBaseController
  def index
    @photos = current_user.photos.order(created_at: :desc)
    @oauth2_tweet_authorize_url = Oauth2::TweetClient.authorize_url
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.new(photo_params)
    
    if @photo.save
      redirect_to photos_path
    else
      render :new
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:title, :image_file)
  end
end
