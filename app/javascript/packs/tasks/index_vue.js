import Vue from 'vue';
import axios from 'axios';
import lodash from 'lodash';

new Vue ({
    el: '#all_tasks',
    data: {
        tasks: [],
        searchQuery: '',
        selected: '',
        createdOrder: true,
        deadLineOrder: false,
        importanceOrder: true
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
            axios.get('api/tasks.json').then(function (response) {
                this.tasks = response.data
            }.bind(this)).catch(function (e) {
                console.error(e)
            })
        },
        reset: function(){
            this.getTasks();
            this.searchQuery = ''
            this.selected = ''
        }
    },
    created: function () {
        this.getTasks();
    }
})

