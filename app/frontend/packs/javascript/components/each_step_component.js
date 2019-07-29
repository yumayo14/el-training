import stepGraphComponent from './each_step_graph_component';

export default {
  data: function() {
    return {
      renderingTasks: false,
    };
  },
  components: {
    stepGraph: stepGraphComponent,
  },
  template: `
               <div v-if="renderingTasks">       
                 <div class="tasks_box">
                   <md-button class="md-primary" v-on:click="showTasks">戻る</md-button>
                   <div class="tasks">
                     <div class="new_task">
                        <button type="button">
                          <span>新しい問題を追加する</span>
                        </button>
                     </div>
                     <div class="all_tasks_in_step">
                       <div class="each_task">
                         <p>アプリ用のSqlユーザーを作成</p>
                       </div>
                       <div class="each_task">
                         <p>テスト環境用のDBを作成</p>
                       </div>
                       <div class="each_task">
                         <p>開発環境用のDBを作成</p>
                       </div>
                       <div class="each_task">
                         <p>詳細を作成する</p>
                       </div>
                     </div>
                   </div>
                 </div>
               </div>
               <div v-else>
                 <button type="button" v-on:click="showTasks">
                   <step-graph></step-graph>
                 </button>
               </div>`,
  methods: {
    showTasks: function() {
      this.renderingTasks = !this.renderingTasks;
    },
  },
};
