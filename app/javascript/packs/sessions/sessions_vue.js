import Vue from 'vue/dist/vue.esm.js';
import {prepareAxios} from '../modules/axios';
import toastr from 'toastr';

window.loginForm = new Vue({
  el: '#login_form',
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
    reloadForm: function(time) {
      (new Promise((resolve)=> {
        resolve(this.processing_login_request = true);
      })).then(function() {
        setTimeout(()=> this.processing_login_request = false, time);
      }.bind(this));
    },
  },
});
