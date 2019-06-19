const formReloadable = {
  methods: {
    reloadForm: function(time) {
      (new Promise((resolve)=> {
        resolve(this.processing_request = true);
      })).then(function() {
        setTimeout(()=> this.processing_request = false, time);
      }.bind(this));
    },
  },
};

export default formReloadable;
