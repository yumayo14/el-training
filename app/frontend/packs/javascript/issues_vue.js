import Vue from 'vue/dist/vue.esm.js';
import {MdContent, MdRipple, MdTable, MdCard, MdLayout} from 'vue-material/dist/components';
import '../stylesheets/application.scss';

Vue.use(MdRipple);
Vue.use(MdContent);
Vue.use(MdTable);
Vue.use(MdCard);
Vue.use(MdLayout);

window.issues = new Vue({
  el: '#issues'
});
