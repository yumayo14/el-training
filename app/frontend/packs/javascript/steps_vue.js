import Vue from 'vue/dist/vue.esm.js';
import '../stylesheets/application.scss';
import {MdContent, MdRipple, MdTable, MdCard, MdLayout, MdButton} from 'vue-material/dist/components';
import step_circle_component from "./modules/step_circle_component";

Vue.use(MdButton);

window.issues = new Vue({
  el: '#steps',
  data: {
    renderingTasks: false
  },
  components: {
    stepCircle: step_circle_component
  },
});
