class GiftsController < ApplicationController
  before_action :set_gift, only: %i[show edit update destroy]
  before_action :set_user, except: %i[destroy]

  def index
    @gifts = @user.gifts
  end

  def show
    @images = @gift.images.all
    @image = @gift.images.build
  end

  def new
    @gift = @user.gifts.build
    @gift.images.build
  end

  def edit; end

  def create
    @gift = @user.gifts.build(title: gift_params[:title], description: gift_params[:description])
    @gift.added_by = current_user
    if @gift.save
      if gift_params[:images_attributes].present?
        Image.transaction do
          gift_params[:images_attributes]['0']['image'].each do |image|
            @gift.images.create(image: image)
          end
        end
      end
      redirect_to user_gifts_path, notice: 'Gift was successfully created.', alert: @gift.errors.messages[:images][0]
    else
      render :new
    end
  end

  def update
    if @gift.update(gift_params)
      redirect_to [@user, @gift], notice: 'Gift was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @gift.destroy
    redirect_to user_gifts_url, notice: 'Gift was successfully removed.'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_gift
    @gift = Gift.find(params[:id])
  end

  def gift_params
    params.require(:gift).permit(:title, :description, images_attributes: [image: []])
  end
end
