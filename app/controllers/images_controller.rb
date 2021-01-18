class ImagesController < ApplicationController
  before_action :set_gift

  def create
    notice = nil
    alert = 'Choose an image first.'
    if image_params[:image].present?
      @gift.images.create(image: image_params[:image][:image])
      notice = 'Image has been added.'
      alert = @gift.errors.messages[:images][0]
    end

    redirect_to user_gift_url(id: @gift), notice: notice, alert: alert
  end

  def destroy
    Image.find(image_params[:id].to_i).destroy
    redirect_to user_gift_url(id: @gift)
  end

  private

  def set_gift
    @gift = Gift.find(params[:gift_id])
  end

  def image_params
    params.permit(:id, image: [:image])
  end
end
