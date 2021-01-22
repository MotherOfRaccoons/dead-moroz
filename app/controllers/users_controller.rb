class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(user_params[:id])
    @assessment = @user.assessments_on.find_by(author: current_user)

    respond_to do |format|
      format.js { @translation = translate(@user.behavior) }
      format.html
    end
  end

  private

  def user_params
    params.permit(:id)
  end

  def translate(text)
    Rails.cache.fetch(['translate', @user.cache_key_with_version], expires_in: 1.hour) do
      params = {
        headers: {
          'x-rapidapi-key': ENV.fetch('X_RAPIDAPI_KEY'),
          'content-type': 'application/x-www-form-urlencoded'
        },
        body: "q=#{text}&source=en&target=fi"
      }

      response = Excon.send(:post, 'https://google-translate1.p.rapidapi.com/language/translate/v2', params)
      JSON.parse(response.body)['data']['translations'].first['translatedText']
    end
  end
end
