import Vue from 'vue/dist/vue.esm.js';
import requestByConfiguredAxios from '../modules/request_by_configured_axios';
import toastr from 'toastr';
import {MdButton, MdField} from 'vue-material/dist/components';
import 'toastr/toastr.scss';
import '../../stylesheets/application.scss';

Vue.use(MdButton);
Vue.use(MdField);

window.loginForm = new Vue({
  el: '#login_form',
  data: {
    method: 'post',
    request_url: '/login',
    accountid: '',
    password: '',
    processing_login_request: false,
  },
  methods: {
    requestLogin: function() {
      requestByConfiguredAxios({method: this.method,
                                url: this.request_url,
                                requestParams: new URLSearchParams({'accountid': this.accountid,
                                                                    'password': this.password}),
                                withCsrf: true,
                                withCookie: false}
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
      })).then(()=> {
        setTimeout(()=> this.processing_login_request = false, time);
      });
    },
  },
});
