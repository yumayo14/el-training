# frozen_string_literal: true

require 'open-uri'

API_KEY = ENV['EL_TRAINING_OPEN_WEATHER_MAP_API_KEY']
BASE_URL = 'http://api.openweathermap.org/data/2.5/weather'

class OpenWeatherMap
  def self.fetch_current_tokyo_weather
    JSON.parse(OpenURI.open_uri(BASE_URL + "?q=Tokyo,jp&units=metric&APPID=#{API_KEY}").read)
  end
end
