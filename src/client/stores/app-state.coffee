Reflux = require 'reflux'
LocationBar = require 'location-bar'
locationBar = new LocationBar()
Actions = require '../actions'

AppState = Reflux.createStore
  currentUrl: ''

  init: ->
    @listenTo Actions.updateLocation, @updateLocation
    console.log 'init AppState+'
    @currentUrl = window.location.href
    locationBar.onChange (path) ->
      console.log '%cNew Path: '+path, 'color: #bada55'

    locationBar.start {pushState: true}

  updateLocation: (url) ->
    console.log('location updating: ', url)
    locationBar.update url
    window.history.pushState(null, "", url)
    @currentUrl = window.location.href
    @trigger()

module.exports = AppState
