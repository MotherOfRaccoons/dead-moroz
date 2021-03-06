class UsersController < ApplicationController
  SORTABLE_COLUMNS = %w[first_name last_name birthdate email].freeze
  include Sortable

  load_and_authorize_resource
  helper_method :user, :sort_column, :sort_direction, :sortable_columns

  def index
    @users = @users.kid.with_not_decided_gifts if can?(:toggle_selected, Gift) && user_params[:not_decided] == 'true'
    @users = @users.by_number_of_reviews if current_user.elf?
    @users = @users.order("#{sort_column} #{sort_direction}").page(user_params[:page])
  end

  def show
    @assessment = user.assessments_on.find_by(author: current_user)

    respond_to do |format|
      format.js do
        @translation = Rails.cache.fetch(['translate', user.cache_key_with_version], expires_in: 1.hour) do
          GoogleTranslate.translate(@user.behavior)
        end
      end
      format.html
    end
  end

  private

  def user
    @user ||= User.find(user_params[:id])
  end

  def user_params
    params.permit(:id, :page, :direction, :sort, :not_decided)
  end
end
