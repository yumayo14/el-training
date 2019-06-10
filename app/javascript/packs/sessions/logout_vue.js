import Vue from 'vue';
import prepareAxios from '../modules/axios';
import toastr from 'toastr';

window.logoutLink = new Vue ({
  el: '#logout_link',
  data: {
    logout_url: '/logout'
  },
  methods: {
    requestLogout: function() {
      prepareAxios({withCsrf: true, withCookie: true}).delete(this.logout_url)
      .then(function(response) {
        window.location.href = response.data;
      });
    },
  }
});
