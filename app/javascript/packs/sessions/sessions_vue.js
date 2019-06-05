import Vue from 'vue';
import prepareAxios from '../modules/axios';
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
      prepareAxios().post(this.login_url,
                          new URLSearchParams({'accountid': this.accountid, 'password': this.password})
      ).then(function(response) {
        window.location.href = response.data.redirect_url;
        toastr.success('ログインに成功しました。');
      }.bind(this)).catch(function() {
        toastr.error('ログインに失敗しました。IDとパスワードを確認してください。');
      }).finally(function() {
        this.reloadForm(1000);
      }.bind(this));
    },
    reloadForm: function(time) {
      (new Promise(resolve =>  {
        resolve(this.processing_login_request = true);
      })).then(function() {
        setTimeout(()=> this.processing_login_request = false, time);
      }.bind(this));
    },
  },
});
