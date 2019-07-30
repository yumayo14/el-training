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
                   <md-field>
                     <label>解決したい問題</label>
                     <md-input v-model="title"></md-input>
                   </md-field>
                   <div class="md-layout md-gutter md-alignment-center-right">
                     <div class="md-layout-item md-size-50 md-small-size-100">
                       <md-field>
                         <label for="movie">着手状態</label>
                         <md-select v-model="status">
                           <md-option value="未着手">未着手</md-option>
                           <md-option value="着手">着手</md-option>
                           <md-option value="完了">完了</md-option>
                         </md-select>
                       </md-field>
                     </div>
                     <div class="md-layout-item md-size-50 md-small-size-100">
                       <md-datepicker v-model="dead_line_on">
                         <label>期限</label>
                       </md-datepicker>
                     </div>
                     <div class="md-layout-item md-size-25">
                       <md-button type="reset" class="md-raised form_button" v-on:click="switchNewFormRendering">キャンセル</md-button>
                     </div>
                     <div class="md-layout-item md-size-25">
                       <md-button type="submit" class="md-primary md-raised form_button">問題を追加</md-button>
                     </div>
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
