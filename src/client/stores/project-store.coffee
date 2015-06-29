I = require 'immutable'
Reflux = require 'reflux'
Request = require 'superagent'
Actions = require '../actions'

store =
  projects: I.Set []
  selectedProject: I.Map {}

  init: ->
    @listenTo Actions.createProject, @addProject
    @getProjects()

  getProjects: ->
    Request.get '/api/projects'
    .end (err, res) =>
      console.log 'I\'m back', res
      @projects = I.fromJS JSON.parse(res.text)
      @trigger()

  addProject: (rec) ->
    Request.post '/api/projects'
    .send(rec)
    .end (err, res) =>
      console.log 'saving project done', err, res
      @getProjects()

  getProject: (id) ->
    Request.get "/api/projects/#{id}"
    .end (err, res) =>
      @selectedProject = I.fromJS JSON.parse(res.text)
      @trigger()

module.exports = Reflux.createStore store
