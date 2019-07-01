# frozen_string_literal: true

API_KEY = ENV['EL_TRAINING_WEATER_API_KEY']
BASE_URL = 'http://api.openweathermap.org/data/2.5/weather'

class OpenWeatherMap
  def fetch_weather_info
    uri = URI.parse(BASE_URL + "?q=Tokyo,jp&APPID=#{API_KEY}")
    response = Net::HTTP.get_response(uri)

    JSON.parse(response.body)
  end
end
