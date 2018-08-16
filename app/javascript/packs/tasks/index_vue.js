import Vue from 'vue';
import axios from 'axios';
import lodash from 'lodash';

new Vue ({
  el: '#all_tasks',
  data: {
    tasks: []
  },
  methods: {
    orderdByCreatedDay: function() {
      this.tasks = _.orderBy(this.tasks, 'created_at', 'desc')
    },
    orderdByDeadLine: function() {
        this.tasks = _.orderBy(this.tasks, 'dead_line_on')
    }
  },
  created: function() {
    axios.get('api/tasks.json').then(function(response) {
      this.tasks = response.data
    }.bind(this)).catch(function(e) {
      console.error(e)
    })
  }
})