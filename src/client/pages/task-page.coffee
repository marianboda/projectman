React = require 'react'
R = React.DOM
Reflux = require 'reflux'
ProjectStore = require '../stores/project-store'
AppState = require '../stores/app-state'
Actions = require '../actions'
A = React.createFactory(require '../components/anchor')
TaskForm = require './task-form'

TaskPage = React.createClass
  displayName: 'task-page'
  mixins: [Reflux.ListenerMixin]

  getInitialState: ->
    tasks: ProjectStore?.tasks ? []
    projects: ProjectStore?.projects ? []
  componentDidMount: ->
    @listenTo ProjectStore, => @setState({tasks: ProjectStore.tasks, projects: ProjectStore.projects})

  taskChecked: (i) -> Actions.switchTaskState(i)

  render: ->
    id = AppState.getPathFragments()[1]
    R.div {className: 'task-page page'},
      R.div {className: 'general-content'},
        R.div {},
          R.select {}, @state.projects.map (i,v) -> R.option {value: i.get('id')}, i.get('name')
          R.hr {}
        A {href: '/tasks/new'}, 'NEW'
        R.table {},
          @state.tasks.map (i,v) =>
            R.tr {style: if Number(i.get('id')) is Number(id) then {background: '#bada55'} else {}},
              R.td {},
                R.input {type: 'checkbox', checked: i.get('status_id') isnt 1, onChange: => @taskChecked(i.get('id'))}
              R.td {},
                A {href: "/tasks/#{i.get('id')}"}, i.get('name')
      R.div {className: 'detail-content'},
        TaskForm {id: parseInt(AppState.getPathFragments()[1]), onSave: (t) -> ProjectStore.addTask(t)}


module.exports = TaskPage
