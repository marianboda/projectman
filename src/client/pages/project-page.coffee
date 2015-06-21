React = require 'react'
R = React.DOM
Reflux = require 'reflux'
ProjectStore = require '../stores/project-store'

ProjectPage = React.createClass
  displayName: 'project-page'
  mixins: [Reflux.ListenerMixin]
  getInitialState: ->
    projects: ProjectStore?.projects ? []
  componentDidMount: ->
    @listenTo ProjectStore, => @setState({projects: ProjectStore.projects})
  render: ->
    console.log ProjectStore.projects
    R.div {},
      R.ul {},
        @state.projects.map( (i) -> R.li {}, i)# for i in ProjectStore.projects

module.exports = ProjectPage
