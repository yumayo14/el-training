let taskFormMixin = {
  data: function() {
    return {
      create_url: '/api/tasks',
      title: '',
      importance: 'low',
      dead_line_on: '',
      status: 'not_started',
      detail: '',
      processing_request: false,
    }
  },
  methods: {
    reloadForm: function(time) {
      (new Promise((resolve)=> {
        resolve(this.processing_request = true);
      })).then(function() {
        setTimeout(()=> this.processing_request = false, time);
      }.bind(this));
    }
  }
};

export default taskFormMixin;
