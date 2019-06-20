import requestByConfiguredAxios from './axios';
import toastr from 'toastr';

export default {
  data: function() {
    return {
      request_url: '',
      method: '',
      title: '',
      importance: 'low',
      dead_line_on: '',
      status: 'not_started',
      detail: '',
      processing_request: false,
    };
  },
  methods: {
    requestUrl: function() {
      requestByConfiguredAxios({method: this.method,
                                url: this.request_url,
                                requestParams: new URLSearchParams({'title': this.title,
                                                                    'importance': this.importance,
                                                                    'dead_line_on': this.dead_line_on,
                                                                    'status': this.status,
                                                                    'detail': this.detail}),
                                withCsrf: true,
                                withCookie: false}

      ).then((response)=> {
        window.location.href = response.data.redirect_url;
      }).catch((error)=> {
        error.response.data.forEach(function(message) {
          toastr.error(message);
        });
      }).finally(()=> {
        this.reloadForm(1000);
      });
    },
    reloadForm: function(time) {
      (new Promise((resolve)=> {
        resolve(this.processing_request = true);
      })).then(function() {
        setTimeout(()=> this.processing_request = false, time);
      }.bind(this));
    },
  },
};
