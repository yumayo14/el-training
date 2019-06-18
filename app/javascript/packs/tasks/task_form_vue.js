import Vue from 'vue/dist/vue.esm.js';
import prepareAxios from '../modules/axios';
import toastr from "toastr";

window.task_form = new Vue ({
  el: '#task_form',
  data: {
    create_url: '/api/tasks',
    title: '',
    importance: 'low',
    dead_line_on: '',
    status: 'not_started',
    detail: '',
    processing_request: false
  },
  methods: {
    createTask: function() {
      prepareAxios({withCsrf: true, withCookie: false}).post(this.create_url,
                                                             new URLSearchParams({'title': this.title,
                                                                                  'importance': this.importance,
                                                                                  'dead_line_on': this.dead_line_on,
                                                                                  'status': this.status,
                                                                                  'detail': this.detail})
      ).then(function(response) {
        window.location.href = response.data.redirect_url;
      }).catch(function(error) {
        error.response.data.forEach(function(message) {toastr.error(message)});
      }).finally(function() {
        this.reloadForm(1000);
      }.bind(this));
    },
    reloadForm: function(time) {
      (new Promise((resolve)=> {
        resolve(this.processing_request = true);
      })).then(function() {
        setTimeout(()=> this.processing_request = false, time);
      }.bind(this));
    },
  }
});
