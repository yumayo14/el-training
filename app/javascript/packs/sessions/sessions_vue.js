import Vue from 'vue';
import axios from 'axios';


axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};


window.loginForm = new Vue ({
    el: '#login_form',
    data: {
      login_url: '/sessions',
      redirect_url: '/tasks',
      accountid: '',
      password: '',
      processing: false
    },
    methods: {
        requestLogin: function() {
            let params = new URLSearchParams();
            params.append('accountid', this.accountid);
            params.append('password', this.password);

            axios.post(this.login_url, params).then(function () {
                window.location.href = this.redirect_url;
            }.bind(this)).catch(function(e) {
                console.log(e);
            }).finally(function() {
                this.reloadForm(1000)
            }.bind(this));
        },
        reloadForm: function(time) {
            (new Promise(resolve =>  {
                resolve(this.processing = true);
            })).then(function (){
                setTimeout(()=> this.processing = false, time)
            }.bind(this));
        }
    }
});
