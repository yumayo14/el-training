import Vue from 'vue/dist/vue.esm.js';
import {MdContent, MdRipple, MdTable, MdCard, MdLayout, MdButton} from 'vue-material/dist/components';
import '../stylesheets/application.scss';
import newIssueForm from './modules/new_issue_form_component';
import step_circle_component from "./modules/step_circle_component";

Vue.use(MdRipple);
Vue.use(MdContent);
Vue.use(MdTable);
Vue.use(MdCard);
Vue.use(MdLayout);
Vue.use(MdButton);

window.issues = new Vue({
  el: '#issues',
  data: {
    method: 'get',
    request_url: '/api/issues/',
    issues: [],
    selectedStatus: '',
    renderingTasks: false
  },
  components: {
    newIssueForm: newIssueForm,
    stepCircle: step_circle_component
  },
  methods: {
    showTasks: function() {
      console.log(this.renderingTasks = !this.renderingTasks);
    }
  }
});
