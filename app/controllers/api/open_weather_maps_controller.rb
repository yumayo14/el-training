# frozen_string_literal: true

class Api::OpenWeatherMapsController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  before_action :fetch_current_tokyo_weather

  def current_tokyo_weather
    if @weather['cod'] != 200
      render json: '天気情報の取得に失敗しました', status: 400
    else
      render json: @weather, status: 200
    end
  end

  private

  def fetch_current_tokyo_weather
    @weather = OpenWeatherMap.fetch_current_tokyo_weather
  end
end
