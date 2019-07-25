import Vue from 'vue/dist/vue.esm.js';
import requestByConfiguredAxios from './modules/request_by_configured_axios';
import toastr from 'toastr';
import {MdContent, MdRipple, MdTable, MdCard, MdLayout, MdButton} from 'vue-material/dist/components';
import '../stylesheets/application.scss';
import eachIssue from './components/each_issue_component';
import newIssueForm from './components/new_issue_form_component';

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
                                // withCookieはログイン機能実装後、trueにする必要がある
                                withCookie: false}
      ).then((response)=> {
        this.issues = response.data.issues;
      }).catch(()=> {
        toastr.error('通信中にエラーが発生しました');
      });
    },
  },
  created: function() {
    this.getIssues();
  },
});
