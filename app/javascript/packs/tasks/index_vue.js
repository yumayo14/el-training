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
        deadLineOrder: true
    },
    methods: {
        orderCreatedDayByDesc: function () {
            this.tasks = _.orderBy(this.tasks, 'created_at', 'desc')
            this.createdOrder = true
        },
        orderCreatedDayByAsc: function () {
            this.tasks = _.orderBy(this.tasks, 'created_at')
            this.createdOrder = false
        },
        orderDeadLineByDesc: function () {
            this.tasks = _.orderBy(this.tasks, 'dead_line_on', 'desc')
            this.deadLineOrder = true
        },
        orderDeadLineByAsc: function () {
            this.tasks = _.orderBy(this.tasks, 'dead_line_on')
            this.deadLineOrder = false
        },
        search: function () {
            this.searchTitle()
            this.searchSelected()
        },
        searchTitle: function() {
            this.tasks = this.tasks.filter(task => task.title.match(this.searchQuery) )
        },
        searchSelected: function () {
            this.tasks = (this.selected != '') ? this.tasks.filter( task => task.status.match(new RegExp('^' + this.selected + '$')) ) : this.tasks
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

