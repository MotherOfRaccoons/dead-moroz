module GoogleTranslate
  module_function

  def translate(text)
    params = {
      headers: {
        'x-rapidapi-key': Rails.application.credentials.dig(:google_translate_api, :x_rapidapi_key),
        'content-type': 'application/x-www-form-urlencoded'
      },
      body: "q=#{text}&source=en&target=fi"
    }

    response = Excon.send(:post, 'https://google-translate1.p.rapidapi.com/language/translate/v2', params)
    JSON.parse(response.body)['data']['translations'].first['translatedText']
  end
end
