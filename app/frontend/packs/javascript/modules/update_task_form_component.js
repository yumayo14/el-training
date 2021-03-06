import taskFormRequestable from './task_form_requestable';

export default {
  props: ['task'],
  mixins: [taskFormRequestable],
  data: function() {
    return {
      method: 'patch',
      request_url: `/api/tasks/` + this.task.id,
      title: this.task.title,
      importance: this.task.importance.value,
      dead_line_on: this.task.dead_line_on,
      status: this.task.status.value,
      detail: this.task.detail,
      editFormRendering: false,
    };
  },
  template: `<div>
               <div>
                 <button v-on:click="switchEditFormRendering">
                   <span v-if="editFormRendering">閉じる</span>
                   <span v-else>編集</span>
                 </button>
               </div>
               <div v-if="editFormRendering">
                 <form v-on:submit.prevent="requestUrl">
                   <div class="title_block">
                     <label for="title_input">タイトル：</label>
                     <input id="title_input" type="text" v-model="title">
                   </div>
                   <div class="importance_block">
                     <label for="importance_select">優先順位：</label>
                     <select id="importance_select" v-model="importance">
                       <option value="low">低</option>
                       <option value="middle">中</option>
                       <option value="high">高</option>
                     </select>
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
                   <div class="detail_block">
                     <label for="detail_text_area">詳細：</label>
                     <textarea id="detail_text_area" rows="2" cols="30" v-model="detail"></textarea>
                   </div>
                   <div class="submit_block">
                     <input type="submit">
                   </div>
                 </form>
               </div>
             </div>
             `,
  methods: {
    switchEditFormRendering: function() {
      this.editFormRendering = !this.editFormRendering;
    },
  },
};
