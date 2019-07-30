export default {
  props: ['issue'],
  template: `
            <md-card class="each_issue">
              <a class="issue_link" href="/issues/{{issue.id}}">
                <md-card-content>
                  <h4 class="issue_title">
                    {{issue.title}}
                  </h4>
                </md-card-content>
              </a>
              <md-card-actions class="md-alignment-left">
                <div class="issue_status">
                  <md-button class="md-primary">
                    {{issue.dead_line_on}}
                  </md-button>
                  <md-button class="md-primary">
                    {{issue.status}}
                  </md-button>
                </div>
              </md-card-actions>
            </md-card>
             `,
};
