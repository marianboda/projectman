React = require 'react'
Reflux = require 'reflux'
R = React.DOM
DbStore = require '../stores/db-store'

page = React.createClass
  mixins: [Reflux.ListenerMixin]
  init: ->
  componentDidMount: ->
    @listenTo DbStore, => @setState {}
  render: ->
    console.log DbStore.tables
    R.div {},
      R.h1 {}, 'DB'
      DbStore.tables?.map (i) -> R.div {}, i.get('name')

module.exports = page
