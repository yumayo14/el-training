import graphComponent from './steps_graph_component';

export default {
  data: function() {
    return {
      width: 350,
      height: 350,
      r: 125,
      fill: '#1A1A26',
      stroke: '#4CAF50',
      renderingTasks: false,
    };
  },
  components: {
    graphChart: graphComponent,
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
                   <graph-chart></graph-chart>
                 </button>
               </div>`,
  methods: {
    showTasks: function() {
      this.renderingTasks = !this.renderingTasks;
    },
  },
};
