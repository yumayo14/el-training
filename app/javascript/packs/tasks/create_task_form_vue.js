import Vue from 'vue/dist/vue.esm.js';
import taskFormRequestable from '../modules/task_form_mixin';

window.task_form = new Vue({
  el: '#task_form',
  mixins: [taskFormRequestable],
  data: {
    method: 'post',
    request_url: '/api/tasks',
  },
});
