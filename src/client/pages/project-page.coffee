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
    R.div {},
      R.input {type: 'text', onChange: @inputChange}
      R.button {onClick: @onBtnClick}, 'ADD PROJECT'
      R.ul {},
        @state.projects.map (i) -> R.li({}, i)

module.exports = ProjectPage
