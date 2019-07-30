import Vue from 'vue/dist/vue.esm.js';
import requestByConfiguredAxios from './modules/request_by_configured_axios';
import toastr from 'toastr';
import {MdContent, MdRipple, MdCard, MdLayout, MdButton, MdField, MdMenu, MdList, MdDatepicker, MdDialog} from 'vue-material/dist/components';
import '../stylesheets/application.scss';
import eachIssue from './components/each_issue_component';
import newIssueForm from './components/new_issue_form_component';

Vue.use(MdRipple);
Vue.use(MdContent);
Vue.use(MdCard);
Vue.use(MdLayout);
Vue.use(MdButton);
Vue.use(MdField);
Vue.use(MdMenu);
Vue.use(MdList);
Vue.use(MdDatepicker);
Vue.use(MdDialog);

window.issues = new Vue({
  el: '#issues',
  data: {
    method: 'get',
    request_url: '/api/issues/',
    issues: [],
  },
  components: {
    eachIssue: eachIssue,
    newIssueForm: newIssueForm,
  },
  methods: {
    getIssues: function() {
      requestByConfiguredAxios({method: this.method,
                                url: this.request_url,
                                withCsrf: false,
                                withCookie: true}
      ).then((response)=> {
        this.issues = response.data;
      }).catch(()=> {
        toastr.error('通信中にエラーが発生しました');
      });
    },
  },
  created: function() {
    this.getIssues();
  },
});
