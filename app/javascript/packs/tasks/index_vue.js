import Vue from 'vue/dist/vue.esm.js';
import {prepareAxios} from '../modules/axios';
import VuePaginator from 'vuejs-paginator';
import _ from 'lodash';

Vue.prototype.$http = prepareAxios({withCsrf: false, withCookie: false});

window.tasks = new Vue({
  el: '#all_tasks',
  data: {
    tasks: [],
    resource_url: '/api/tasks',
    options: {
      remote_data: 'nested.data',
      remote_current_page: 'nested.current_page',
      remote_last_page: 'nested.last_page',
      remote_next_page_url: 'nested.next_page_url',
      remote_prev_page_url: 'nested.prev_page_url',
      next_button_text: 'Go Next',
      previous_button_text: 'Go Back',
    },
    searchQuery: '',
    selectedStatus: '',
    createdOrder: true,
    deadLineOrder: false,
    importanceOrder: true,
  },
  components: {
    VPaginator: VuePaginator,
  },
  methods: {
    orderByCreatedDay: function() {
      (this.createdOrder) ? (
        this.tasks = _.orderBy(this.tasks, 'created_at', 'desc'),
        this.createdOrder = !this.createdOrder
      ) : (
        this.tasks = _.orderBy(this.tasks, 'created_at'),
        this.createdOrder = !this.createdOrder
      );
    },
    orderByDeadLine: function() {
      (this.deadLineOrder) ? (
        this.tasks = _.orderBy(this.tasks, 'dead_line_on', 'desc'),
        this.deadLineOrder = !this.deadLineOrder
      ) : (
        this.tasks = _.orderBy(this.tasks, 'dead_line_on'),
        this.deadLineOrder = !this.deadLineOrder
      );
    },
    orderByImportance: function() {
      (this.importanceOrder) ? (
        this.tasks = _.orderBy(this.tasks, 'importance.rank', 'desc'),
        this.importanceOrder = !this.importanceOrder
      ) : (
        this.tasks = _.orderBy(this.tasks, 'importance.rank'),
        this.importanceOrder = !this.importanceOrder
      );
    },
    search: function() {
      prepareAxios({withCsrf: false, withCookie: true}).get(this.resource_url, {
        params: {
          title: this.searchQuery,
          status: this.selectedStatus,
        },
      }).then(function(response) {
        this.tasks = response.data.nested.data;
      }.bind(this)).catch(function(e) {
        alert(e);
      });
    },
    getTasks: function() {
      prepareAxios({withCsrf: false, withCookie: true}).get(this.resource_url).then((response)=> {
        this.tasks = response.data.nested.data;
      }).catch(function(e) {
        alert(e);
      });
    },
    reset: function() {
      this.getTasks();
      this.searchQuery = '';
      this.selectedStatus = '';
    },
    updateResource: function(data) {
      this.tasks = data;
    },
  },
  created: function() {
    this.getTasks();
  },
});
