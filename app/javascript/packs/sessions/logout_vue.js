import Vue from 'vue/dist/vue.esm.js';
import requestByConfiguredAxios from '../modules/axios';

window.logoutLink = new Vue({
  el: '#logout_link',
  data: {
    method: 'delete',
    request_url: '/logout',
  },
  methods: {
    requestLogout: function() {
      requestByConfiguredAxios({method: this.method,
                                url: this.request_url,
                                requestParams: null,
                                withCsrf: true,
                                withCookie: true}
      ).then((response)=> {
        window.location.href = response.data;
      });
    },
  },
});
