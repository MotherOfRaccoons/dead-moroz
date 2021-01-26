class GiftsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource through: :user
  skip_load_resource only: :create
  helper_method :user, :gift

  def index; end

  def show
    @images = gift.images.all
    @image = gift.images.build
  end

  def new
    @gift.images.build
  end

  def edit; end

  def create
    @gift = user.gifts.build(title: gift_params[:title], description: gift_params[:description], added_by: current_user)
    if @gift.save
      create_images if gift_params[:images_attributes].present?
      redirect_to user_gifts_path, notice: 'Gift was successfully created.', alert: @gift.errors.messages[:images][0]
    else
      render :new
    end
  end

  def update
    if gift.update(gift_params)
      redirect_to [user, gift], notice: 'Gift was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    gift.destroy
    redirect_to user_gifts_url, notice: 'Gift was successfully removed.'
  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end

  def gift
    @gift ||= Gift.find(params[:id])
  end

  def create_images
    Image.transaction do
      gift_params[:images_attributes]['0']['image'].each do |image|
        @gift.images.create(image: image)
      end
    end
  end

  def gift_params
    params.require(:gift).permit(:title, :description, images_attributes: [image: []])
  end
end
