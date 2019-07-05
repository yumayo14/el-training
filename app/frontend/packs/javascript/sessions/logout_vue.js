import Vue from 'vue/dist/vue.esm.js';
import requestByConfiguredAxios from '../modules/request_by_configured_axios';

window.logoutLink = new Vue({
  el: '#logout_link',
  data: {
    method: 'delete',
    request_url: '/logout',
  },
  methods: {
    requestLogout: function() {
      if (window.confirm('ログアウトしますか？')) {
        requestByConfiguredAxios({method: this.method,
                                  url: this.request_url,
                                  withCsrf: true,
                                  withCookie: true}
        ).then((response)=> {
          window.location.href = response.data;
        });
      }
    },
  },
});
