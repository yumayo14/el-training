import Vue from 'vue/dist/vue.esm.js';
import '../stylesheets/application.scss';
import {MdButton} from 'vue-material/dist/components';
import eachStepComponent from './components/each_step_component';

Vue.use(MdButton);

window.issues = new Vue({
  el: '#steps',
  components: {
    eachStep: eachStepComponent,
  },
});
