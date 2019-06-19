import Vue from 'vue/dist/vue.esm.js';
import formReloadable from '../modules/form_common_mixin';
import prepareAxios from '../modules/axios';
import toastr from 'toastr';

window.loginForm = new Vue({
  el: '#login_form',
  mixins: [formReloadable],
  data: {
    login_url: '/login',
    accountid: '',
    password: '',
    processing_login_request: false,
  },
  methods: {
    requestLogin: function() {
      prepareAxios({withCsrf: true, withCookie: false}).post(this.login_url,
                                                             new URLSearchParams({'accountid': this.accountid,
                                                                                  'password': this.password})
      ).then((response)=> {
        window.location.href = response.data.redirect_url;
      }).catch((error)=> {
        toastr.error(error.response.data);
      }).finally(()=> {
        this.reloadForm(1000);
      });
    },
  },
});
