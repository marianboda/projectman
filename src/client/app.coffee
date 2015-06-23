request = require 'superagent'
React = require 'react'
Reflux = require 'reflux'
ProjectPage = require './pages/project-page'
AppState = require './stores/app-state'
Actions = require './actions'

App = React.createClass
  displayName: 'app'
  mixins: [Reflux.ListenerMixin]

  linkClick: (e) ->
    Actions.updateLocation e.currentTarget.href
    e.preventDefault()


  componentDidMount: ->
    @listenTo AppState, => @setState {}
  render: ->
    console.log AppState.currentUrl + '----'
    React.DOM.div {},
      React.DOM.h1 {}, AppState.currentUrl
      React.DOM.a {href: 'pros', onClick: @linkClick}, 'PROS'
      React.DOM.a {href: 'tasks', onClick: @linkClick}, ' TASKS'

      React.createElement ProjectPage


React.render React.createElement(App), document.body
