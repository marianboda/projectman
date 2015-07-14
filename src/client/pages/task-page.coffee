React = require 'react'
R = React.DOM
Reflux = require 'reflux'
ProjectStore = require '../stores/project-store'
AppState = require '../stores/app-state'
Actions = require '../actions'
A = React.createFactory(require '../components/anchor')

TaskPage = React.createClass
  displayName: 'task-page'
  mixins: [Reflux.ListenerMixin]

  getInitialState: ->
    tasks: ProjectStore?.tasks ? []
  componentDidMount: ->
    @listenTo ProjectStore, => @setState({tasks: ProjectStore.tasks})

  render: ->
    R.div {className: 'task-page'},
      R.h1 {}, 'Tasks'
      R.table {},
        @state.tasks.map (i,v) ->
          R.tr {},
            R.td {}, R.input {type: 'checkbox'}
            R.td {},
              A {href: "/tasks/#{i.get('id')}"}, i.get('name')

module.exports = TaskPage
