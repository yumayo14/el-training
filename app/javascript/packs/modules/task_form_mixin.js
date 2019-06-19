const taskFormDataSharable = {
  data: function() {
    return {
      create_url: '/api/tasks',
      title: '',
      importance: 'low',
      dead_line_on: '',
      status: 'not_started',
      detail: '',
      processing_request: false,
    };
  },
};

export default taskFormDataSharable;
