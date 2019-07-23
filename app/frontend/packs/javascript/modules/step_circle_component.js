export default {
  data: function() {
    return {
      width: 250,
      height: 250,
      r: 125,
      fill: '#1A1A26',
      stroke: '#4CAF50',
    }
  },
  template: `<svg :width="width" :height="height">
               <circle :cx="125"
                       :cy="125"
                       :r="r"
                       :fill="fill"
                       :stroke="stroke">
               </circle>
             </svg>`,
};
