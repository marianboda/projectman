React = require 'react'
R = React.DOM
Reflux = require 'reflux'
ProjectStore = require '../stores/project-store'
AppState = require '../stores/app-state'
Actions = require '../actions'
A = React.createFactory(require '../components/anchor')

ProjectPage = React.createClass
  displayName: 'project-page'
  mixins: [Reflux.ListenerMixin]

  getInitialState: ->
    projects: ProjectStore?.projects ? []
    newProject: name: ''
    selectedProjectId: null

  componentDidMount: ->
    @listenTo ProjectStore, => @setState({projects: ProjectStore.projects})

  onBtnClick: ->
    Actions.createProject(@state.newProject)
    @setState newProject: {name: ''}

  inputChange: ->
    @setState newProject: name: event.target.value

  getSelectedProjectId: ->
    frags = AppState.getPathFragments()
    console.log frags
    if (frags.length > 1) then frags[1] else null

  render: ->
    @state.projects
    selectedProjectId = @getSelectedProjectId()

    detail = null
    if selectedProjectId?
      ProjectStore.getProject(selectedProjectId)

      detail = [
        R.h2 {}, ProjectStore.selectedProject.get('name')
        R.div {}, 'ID: ' + selectedProjectId
      ]

    R.div {className: 'project-page'},
      R.div {className: 'left-panel'},
        R.input {type: 'text', onChange: @inputChange, value: @state.newProject.name}
        R.button {onClick: @onBtnClick}, 'ADD PROJECT'
        R.table {},
          R.tbody {},
            @state.projects.map (i,v) ->
              R.tr {},
                R.td {}, i.get('id')
                R.td {},
                  A {href: "/pros/#{i.get('id')}"}, i.get('name')
      R.div {className: 'right-panel'},
        detail


module.exports = ProjectPage
