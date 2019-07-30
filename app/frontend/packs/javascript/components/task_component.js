import { library } from '@fortawesome/fontawesome-svg-core'
import { faTimes  } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

library.add(faTimes);

export default {
  data: function() {
    return {
      finished: false,
      mouseOver: false
    };
  },
  components: {
    fontAwesomeIcon: FontAwesomeIcon,
  },
  template: `<div v-on:mouseover="showTaskDeleteButton" v-on:mouseleave="hideTaskDeleteButton">
               <div class="each_task" v-if="mouseOver">
                 <div class="task_status">
                   <input type="checkbox" id="checkbox" v-model="checked">
                 </div>
                 <div class="task_title">
                   <p>
                     <slot></slot>
                   </p>
                 </div>
                 <div class="delete_task">
                   <button>
                     <font-awesome-icon icon="times" size="lg" :style="{ color: '#ef5350' }"></font-awesome-icon>
                   </button>
                 </div>
               </div>
               <div class="each_task" v-else>
                 <div class="task_status"> 
                   <input type="checkbox" id="checkbox" v-model="checked">
                 </div>
                 <div class="task_title">
                   <p>
                     <slot></slot>
                   </p>
                 </div>
               </div>
             </div>
             `,
  methods: {
    showTaskDeleteButton: function() {
      this.mouseOver = true;
    },
    hideTaskDeleteButton: function() {
      this.mouseOver = false;
    }
  }
}
