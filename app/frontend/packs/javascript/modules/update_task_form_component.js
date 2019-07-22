import taskFormRequestable from './task_form_requestable';

export default {
  mixins: [taskFormRequestable],
  data: function() {
    return {
      method: 'post',
      request_url: `/api/issues/`,
      title: '',
      dead_line_on: '',
      status: '',
      newFormRendering: false,
    };
  },
  template: `<div>
               <div v-if="newFormRendering">
                 <form v-on:submit.prevent="requestUrl">
                   <div class="title_block">
                     <label for="title_input">タイトル：</label>
                     <input id="title_input" type="text" v-model="title">
                   </div>
                   <div class="dead_line_on_block">
                     <label for="dead_line_on_input">期限：</label>
                     <input id="dead_line_on_input" type="date" v-model="dead_line_on">
                   </div>
                   <div class="status_block">
                     <label for="status_select">状態：</label>
                     <select id="status_select" v-model="status">
                       <option value="not_started">未着手</option>
                       <option value="working">着手</option>
                       <option value="completed">完了</option>
                     </select>
                   </div>
                   <div class="submit_block">
                     <input type="submit">
                   </div>
                   <div class="cancel_block">
                     <input type="reset" v-on:click="switchNewFormRendering">
                   </div>
                 </form>
               </div>
               <div v-else>
                 <div class="new_issue">
                   <button type="button" v-on:click="switchNewFormRendering">
                     <span>新しい問題を追加する</span>
                   </button>
                 </div>
               </div>
             </div>
             `,
  methods: {
    switchNewFormRendering: function() {
      this.newFormRendering = !this.newFormRendering;
    },
  },
};
