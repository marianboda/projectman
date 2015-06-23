React = require 'react'
R = React.DOM
Reflux = require 'reflux'
ProjectStore = require '../stores/project-store'
Actions = require '../actions'

TaskPage = React.createClass
  displayName: 'task-page'
  # mixins: [Reflux.ListenerMixin]

  render: ->
    R.h1 {}, 'Task page'

module.exports = TaskPage
