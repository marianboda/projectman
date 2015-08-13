request = require 'superagent'
React = require 'react'
Reflux = require 'reflux'

R = React.DOM

ProjectPage = require './pages/project-page'
TaskPage = require './pages/task-page'
DbPage = require './pages/db-page'
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
    if path.match(/^\/db/i)?
      page = DbPage

    menuItems = []
    if (AppState.user?.id?)
      menuItems = menuItems.concat [
        R.a {href: '/pros', onClick: @linkClick}, 'PROS'
        R.a {href: '/pros/some', onClick: @linkClick}, 'PROS/SOME'
        R.a {href: '/tasks', onClick: @linkClick}, 'TASKS'
        R.a {href: '/db', onClick: @linkClick}, 'DB'
        R.a {href: '/user', onClick: @linkClick}, 'U-S-E-R'
        R.span {}, AppState.user.displayName
        R.a {href: '/logout'}, 'LOGOUT'
      ]
    else
      menuItems = menuItems.concat [
        R.a {href: '/auth/google'}, 'GOOGLE LOGIN'
      ]

    R.div {className: 'main-container'},
      R.div {className: 'top-bar'},
        R.h1 {}, AppState.currentUrl
        R.span {}, menuItems

      R.div {className: 'content-container'},
        React.createElement page if page?

React.render React.createElement(App), document.body
