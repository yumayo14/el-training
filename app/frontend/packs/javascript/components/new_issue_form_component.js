import requetByConfiguredAxios from '../modules/request_by_configured_axios';
import toastr from 'toastr';
import 'toastr/toastr.scss';

export default {
  data: function() {
    return {
      method: 'post',
      request_url: `/api/issues/`,
      title: '',
      dead_line_on: '',
      status: '',
      newFormRendering: false,
      processing_create_request: false,
    };
  },
  template: `<div>
               <div v-if="newFormRendering">
                 <form v-on:submit.prevent="createNewTask">
                   <div class="title_block">
                     <label for="title_input">タイトル：</label>
                     <input id="title_input" type="text" v-model="title">
                   </div>
                   <div class="dead_line_on_block">
                     <label for="dead_line_on_input">期限：</label>
                     <input id="dead_line_on_input" type="date" min="2019-07-20" v-model="dead_line_on">
                   </div>
                   <div class="status_block">
                     <label for="status_select">状態：</label>
                     <select id="status_select" v-model="status">
                       <option value="未着手">未着手</option>
                       <option value="着手">着手</option>
                       <option value="完了">完了</option>
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
    createNewTask: function() {
      requetByConfiguredAxios({method: this.method,
                               url: this.request_url,
                               requestParams: new URLSearchParams({'title': this.title,
                                                                   'dead_line_on': this.dead_line_on,
                                                                   'status': this.status}),
                               withCsrf: true,
                               withCookie: false}
      ).then(()=> {
        toastr.success('問題の追加に成功しました');
        this.$root.getIssues();
        this.initializeForm();
      }).catch((error)=> {
        error.response.data.forEach((message)=> {
          toastr.error(message);
        });
      }).finally(()=> {
        this.reloadForm(1000);
      });
    },
    initializeForm: function() {
      this.title = '';
      this.dead_line_on = '';
      this.status = '';
    },
    reloadForm: function(time) {
      (new Promise((resolve)=> {
        resolve(this.processing_create_request = true);
      })).then(()=> {
        setTimeout(()=> this.processing_create_request = false, time);
      });
    },
    switchNewFormRendering: function() {
      this.newFormRendering = !this.newFormRendering;
    },
  },
};
