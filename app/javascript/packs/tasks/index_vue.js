import Vue from 'vue';
import axios from 'axios';
import VuePaginator from 'vuejs-paginator';
import lodash from 'lodash';

Vue.prototype.$http = axios

window.tasks = new Vue ({
    el: '#all_tasks',
    data: {
        tasks: [],
        resort_url: 'tasks.json',
        resource_url: '/api/tasks.json',
        options: {
            remote_data: 'nested.data',
            remote_current_page: 'nested.current_page',
            remote_last_page: 'nested.last_page',
            remote_next_page_url: 'nested.next_page_url',
            remote_prev_page_url: 'nested.prev_page_url',
            next_button_text: 'Go Next',
            previous_button_text: 'Go Back'
        },
        searchQuery: '',
        selected: '',
        createdOrder: true,
        deadLineOrder: false,
        importanceOrder: true
    },
    components: {
        VPaginator: VuePaginator
    },
    methods: {
        orderByCreatedDay: function () {
            (this.createdOrder) ? (
                this.tasks = _.orderBy(this.tasks, 'created_at', 'desc'),
                this.createdOrder = !this.createdOrder
            ) : (
                this.tasks = _.orderBy(this.tasks, 'created_at'),
                this.createdOrder = !this.createdOrder
            )
        },
        orderByDeadLine: function () {
            (this.deadLineOrder) ? (
                this.tasks = _.orderBy(this.tasks, 'dead_line_on', 'desc'),
                this.deadLineOrder = !this.deadLineOrder
            ) : (
                this.tasks = _.orderBy(this.tasks, 'dead_line_on'),
                this.deadLineOrder = !this.deadLineOrder
            )
        },
        orderByImportance: function () {
            (this.importanceOrder) ? (
                this.tasks = _.orderBy(this.tasks, 'importance.rank', 'desc'),
                this.importanceOrder = !this.importanceOrder
            ) : (
                this.tasks = _.orderBy(this.tasks, 'importance.rank'),
                this.importanceOrder = !this.importanceOrder
            )
        },
        search: function () {
            this.searchByTitle()
            this.searchBySelected()
        },
        searchByTitle: function() {
            this.tasks = this.tasks.filter(task => task.title.match(this.searchQuery) )
        },
        searchBySelected: function () {
            this.tasks = (this.selected != '') ? this.tasks.filter( task => task.status.num == this.selected ) : this.tasks
        },
        getTasks: function(){
            axios.get(this.resource_url).then(function (response) {
                console.log(response);
                this.tasks = response.data.nested.data
            }.bind(this)).catch(function (e) {
                console.error(e)
            })
        },
        reset: function(){
            this.getTasks();
            this.searchQuery = ''
            this.selected = ''
        },
        updateResource: function(data) {
            this.tasks = data
        }
    },
    created: function () {
        this.getTasks();
    }
})
console.log(tasks)
