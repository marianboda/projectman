request = require 'superagent'
React = require 'react'
Reflux = require 'reflux'
ProjectPage = require './pages/project-page'
TaskPage = require './pages/task-page'
AppState = require './stores/app-state'
Actions = require './actions'

require '../styles/app.sass'


App = React.createClass
  displayName: 'app'
  mixins: [Reflux.ListenerMixin]

  linkClick: (e) ->
    Actions.updateLocation e.currentTarget.href
    e.preventDefault()

  componentDidMount: ->
    @listenTo AppState, => @setState {}
  render: ->
    path = AppState.location.pathname

    page = null

    if path.match(/^\/pros/i)?
      page = ProjectPage
    if path.match(/^\/tasks/i)?
      page = TaskPage

    React.DOM.div {},
      React.DOM.h1 {}, AppState.currentUrl
      React.DOM.a {href: '/pros', onClick: @linkClick}, 'PROS'
      React.DOM.a {href: '/pros/some', onClick: @linkClick}, ' PROS/SOME'
      React.DOM.a {href: '/tasks', onClick: @linkClick}, ' TASKS'
      React.DOM.hr {}

      React.createElement page if page?


React.render React.createElement(App), document.body
