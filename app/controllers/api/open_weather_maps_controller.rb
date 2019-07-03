# frozen_string_literal: true

class Api::OpenWeatherMapsController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  def current_tokyo_weather
    @weather = OpenWeatherMap.fetch_current_tokyo_weather
    if @weather['cod'] != 200
      render json: '天気情報の取得に失敗しました', status: @weather['cod']
    else
      render json: @weather, status: 200
    end
  end
end
