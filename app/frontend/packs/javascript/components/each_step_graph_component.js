import {Doughnut} from 'vue-chartjs';

export default {
  extends: Doughnut,
  data: function() {
    return {
      graphData: {
        labels: ['完了', '未完了'],
        datasets: [{
          data: [70, 30],
          backgroundColor: ['#4CAF50', '#EF8157'],
        }],
      },
      option: {
        cutoutPercentage: 75,
        legend: {
          labels: {
            fontColor: 'white',
          },
        },
      },
    };
  },
  mounted: function() {
    this.renderChart(this.graphData, this.option);
  },
};