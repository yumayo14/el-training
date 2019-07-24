import Vue from 'vue/dist/vue.esm.js';
import '../stylesheets/application.scss';
import {MdButton} from 'vue-material/dist/components';
import stepCircleComponent from "./modules/step_circle_component";

Vue.use(MdButton);

window.issues = new Vue({
  el: '#steps',
  components: {
    stepCircle: stepCircleComponent
  },
});
