Url = require 'url'
Reflux = require 'reflux'
Actions = require '../actions'

AppState = Reflux.createStore
  location: null

  init: ->
    @listenTo Actions.updateLocation, @updateLocation
    console.log 'init AppState+'
    @location = Url.parse(window.location.href, true)

  getPathFragments: ->
    location.pathname.substring(1).split('/')

  updateLocation: (url) ->
    @location = Url.parse(url, true)
    console.log('location updating: ', @location.href)
    history.pushState(null, "", url)
    @trigger()

module.exports = AppState
