# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::OpenWeatherMaps', type: :request do
  describe '#current_tokyo_weather' do
    context 'リクエストに成功した場合' do
      before do
        allow(OpenWeatherMap).to receive(:fetch_current_tokyo_weather).and_return('message' => 'success!', 'cod' => 200)
        get api_open_weather_maps_path
      end
      let(:responsed_data) { JSON.parse(response.body) }
      it '外部APIから取得した天気の情報を返す' do
        expect(responsed_data['message']).to eq 'success!'
      end
      it 'ステータス200を返す' do
        expect(response.status).to eq 200
      end
    end
    context 'リクエストに失敗した場合' do
      context 'OpenWeatherMapから401のステータスコードが返ってきた場合' do
        before do
          allow(OpenWeatherMap).to receive(:fetch_current_tokyo_weather).and_return('cod' => 401)
          get api_open_weather_maps_path
        end
        it 'エラーメッセージを返す' do
          expect(response.body).to eq '天気情報の取得に失敗しました'
        end
        it 'ステータス400を返す' do
          expect(response.status).to eq 400
        end
      end
      context 'OpenWeatherMapから404のステータスコードが返ってきた場合' do
        before do
          allow(OpenWeatherMap).to receive(:fetch_current_tokyo_weather).and_return('cod' => 404)
          get api_open_weather_maps_path
        end
        it 'エラーメッセージを返す' do
          expect(response.body).to eq '天気情報の取得に失敗しました'
        end
        it 'ステータス400を返す' do
          expect(response.status).to eq 400
        end
      end
    end
  end
end
