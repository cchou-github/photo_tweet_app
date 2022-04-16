class PicturesController < ApplicationController
  def index
    @pictures = current_user.pictures.order(created_at: :desc)
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = current_user.pictures.new(picture_params)
    
    if @picture.save
      redirect_to pictures_path
    else
      render new_picture_path
    end
  end

  private
  def picture_params
    params.require(:picture).permit(:title, :image_file)
  end
end
