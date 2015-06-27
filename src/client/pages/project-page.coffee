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

  componentDidMount: ->
    @listenTo ProjectStore, => @setState({projects: ProjectStore.projects})

  onBtnClick: ->
    Actions.createProject(@state.newProject)

  inputChange: ->
    @setState
      newProject:
        name: event.target.value

  getSelectedProjectId: ->
    frags = AppState.getPathFragments()
    console.log frags
    if (frags.length > 1) then frags[1] else null

  render: ->
    @state.projects
    selectedProject = @getSelectedProjectId()

    detail = null
    if selectedProject?
      console.log 'hereee'
      detail = [
        R.h2 {}, 'DETAIL'
        R.div {}, 'TOTO JE DETAIL NEJAKEHO PROJEKTU: ' + selectedProject
      ]

    R.div {className: 'project-page'},
      R.div {className: 'left-panel'},
        R.input {type: 'text', onChange: @inputChange}
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
