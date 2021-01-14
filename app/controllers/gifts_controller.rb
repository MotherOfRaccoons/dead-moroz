class GiftsController < ApplicationController
  before_action :set_gift, only: [:show, :edit, :update, :destroy]

  def index
    @gifts = Gift.all
  end

  def show
  end

  def new
    @gift = Gift.new
  end

  def edit
  end

  def create
    @gift = current_user.gifts.new(gift_params)
    @gift.added_by = User.find(params[:user_id])
    if @gift.save
      redirect_to [current_user, @gift], notice: 'Gift was successfully created.'
    else
      render :new
    end
  end

  def update
    if @gift.update(gift_params)
      redirect_to @gift, notice: 'Gift was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @gift.destroy
    redirect_to gifts_url, notice: 'Gift was successfully destroyed.'
  end

  private
    def set_gift
      @gift = Gift.find(params[:id])
    end

    def gift_params
      params.require(:gift).permit(:title)
    end
end
