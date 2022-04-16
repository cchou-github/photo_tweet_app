class PhotosController < ApplicationController
  def index
    @photos = current_user.photos.order(created_at: :desc)
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.new(photo_params)
    
    if @photo.save
      redirect_to photos_path
    else
      render new_photo_path
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:title, :image_file)
  end
end
