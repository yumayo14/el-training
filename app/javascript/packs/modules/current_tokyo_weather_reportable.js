import requestByConfiguredAxios from './request_by_configured_axios';
import toastr from 'toastr';
import 'toastr/toastr.scss';

export default {
  data: function() {
    return {
      method_for_open_weather_map: 'get',
      request_url_for_open_weather_map: '/api/open_weather_maps',
      weather: {
        id: 0,
        main: '',
        description: '',
        icon: '',
      },
    };
  },
  methods: {
    fetchCurrentTokyoWeather: function() {
      requestByConfiguredAxios({method: this.method_for_open_weather_map,
                                url: this.request_url_for_open_weather_map,
                                withCsrf: false,
                                withCookie: false}
      ).then((response)=> {
        this.weather = response.data.weather[0];
      }).catch((error)=> {
        toastr.error(error.response.data);
      });
    },
  },
  computed: {
    weatherImageUrl: function() {
      return `http://openweathermap.org/img/wn/${this.weather.icon}@2x.png`;
    },
  },
};
