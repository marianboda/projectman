I = require 'immutable'
Reflux = require 'reflux'
Request = require 'superagent'
Actions = require '../actions'

store =
  tables: I.Set []

  init: ->
    #@listenTo Actions.createProject, @addProject
    @getTables()

  getTables: ->
    Request.get '/api/tables'
    .end (err, res) =>
      @projects = I.fromJS JSON.parse(res.text)
      @trigger()

module.exports = Reflux.createStore store
