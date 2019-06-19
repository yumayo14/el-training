import Vue from 'vue/dist/vue.esm.js';
import formReloadable from '../modules/form_common_mixin';
import taskFormSharable from '../modules/task_form_mixin';
import prepareAxios from '../modules/axios';
import toastr from 'toastr';

window.task_form = new Vue({
  el: '#task_form',
  mixins: [formReloadable, taskFormSharable],
  methods: {
    createTask: function() {
      prepareAxios({withCsrf: true, withCookie: false}).post(this.create_url,
                                                             new URLSearchParams({'title': this.title,
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
  },
});
