import Vue from 'vue/dist/vue.esm.js';
import {MdContent, MdRipple, MdTable, MdCard, MdLayout, MdButton} from 'vue-material/dist/components';
import '../stylesheets/application.scss';
import newIssueForm from './modules/new_issue_form_component';
import stepCircleComponent from './modules/step_circle_component';

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
  },
  components: {
    newIssueForm: newIssueForm,
  },
});
