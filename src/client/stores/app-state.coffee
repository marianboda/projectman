Url = require 'url'
Reflux = require 'reflux'
Actions = require '../actions'
Request = require 'superagent'

AppState = Reflux.createStore
  location: null
  user: null

  init: ->
    @listenTo Actions.updateLocation, @updateLocation
    console.log 'init AppState+'
    @location = Url.parse(window.location.href, true)
    @getInitialState()

  getInitialState: ->
    Request.get("/api/app-state").end (err, res) =>
      console.log 'fun and games'
      @user = JSON.parse(res.text)
      console.log 'USER',@user
      @trigger()


  getPathFragments: ->
    location.pathname.substring(1).split('/')

  updateLocation: (url) ->
    @location = Url.parse(url, true)
    console.log('location updating: ', @location.href)
    history.pushState(null, "", url)
    @trigger()

module.exports = AppState
