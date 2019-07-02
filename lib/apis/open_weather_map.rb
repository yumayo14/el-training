# frozen_string_literal: true

require 'open-uri'

API_KEY = Rails.application.credentials.api[:open_weather_map_keys]
BASE_URL = 'http://api.openweathermap.org/data/2.5/weather'

class OpenWeatherMap
  def self.fetch_current_tokyo_weather
    JSON.parse(OpenURI.open_uri(BASE_URL + "?q=Tokyo,jp&units=metric&APPID=#{API_KEY}").read)
  end
end
