React = require 'react'
R = React.DOM
Reflux = require 'reflux'
ProjectStore = require '../stores/project-store'
Actions = require '../actions'

ProjectPage = React.createClass
  displayName: 'project-page'
  mixins: [Reflux.ListenerMixin]

  getInitialState: ->
    projects: ProjectStore?.projects ? []
    newProject: name: ''

  componentDidMount: ->
    @listenTo ProjectStore, => @setState({projects: ProjectStore.projects})

  onBtnClick: ->
    Actions.createProject(@state.newProject)

  inputChange: ->
    @setState
      newProject:
        name: event.target.value
  render: ->
    @state.projects
    R.div {className: 'project-page'},
      R.div {className: 'left-panel'},
        R.input {type: 'text', onChange: @inputChange}
        R.button {onClick: @onBtnClick}, 'ADD PROJECT'
        R.table {},
          R.tbody {},
            @state.projects.map (i,v) -> R.tr({}, [R.td({}, i.get('id')),R.td({}, i.get('name'))])
      R.div {className: 'right-panel'}
        R.h2 {}, 'DETAIL'

module.exports = ProjectPage
