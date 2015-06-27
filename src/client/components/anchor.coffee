React = require 'react'
R = React.DOM
Actions = require '../actions'

Anchor = React.createClass
  init: ->
  linkClick: (e) ->
    Actions.updateLocation e.currentTarget.href
    e.preventDefault()

  render: ->
    R.a {href: @props.href, onClick: @linkClick}, @props.children

module.exports = Anchor
