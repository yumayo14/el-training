import prepareAxios from './axios';
import toastr from 'toastr';

export default {
  data: function() {
    return {
      url: '',
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
      prepareAxios({withCsrf: true, withCookie: false}).post(this.url,
                                                             new URLSearchParams({
                                                               'title': this.title,
                                                               'importance': this.importance,
                                                               'dead_line_on': this.dead_line_on,
                                                               'status': this.status,
                                                               'detail': this.detail})
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
