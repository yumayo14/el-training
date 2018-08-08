import Vue from 'vue';
import axios from 'axios';

const Tasks = new Vue ({
  el: '#all_tasks',
  data: {
    tasks: []
  },
  methods: {
    handleClick: function() {
      alert('クリックしたよ')
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