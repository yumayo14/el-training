import Vue from 'vue';
import axios from '../modules/axios';
import toastr from 'toastr';

window.loginForm = new Vue ({
    el: '#login_form',
    data: {
      login_url: '/sessions',
      accountid: '',
      password: '',
      processing_login_request: false
    },
    methods: {
        requestLogin: function() {
            let params = new URLSearchParams();
            params.append('accountid', this.accountid);
            params.append('password', this.password);

            axios.post(this.login_url, params).then(function (response) {
                window.location.href = response.data.redirect_url;
                toastr.success('認証に成功しました。');
            }.bind(this)).catch(function(e) {
                toastr.error('認証に失敗しました。IDとパスワードを確認してください。');
            }).finally(function() {
                this.reloadForm(1000)
            }.bind(this));
        },
        reloadForm: function(time) {
            (new Promise(resolve =>  {
                resolve(this.processing_login_request = true);
            })).then(function (){
                setTimeout(()=> this.processing_login_request = false, time)
            }.bind(this));
        }
    }
});
