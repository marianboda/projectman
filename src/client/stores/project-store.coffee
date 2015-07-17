I = require 'immutable'
Reflux = require 'reflux'
Request = require 'superagent'
Actions = require '../actions'

store =
  projects: I.Set []
  tasks: I.List []
  selectedProject: I.Map {}

  init: ->
    @listenTo Actions.createProject, @addProject
    @listenTo Actions.switchTaskState, @switchTaskState
    @getProjects()
    @getTasks()

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
    return if parseInt(id) is parseInt(@selectedProject?.get('id'))
    console.log 'selecting project: ' + id
    Request.get("/api/projects/#{id}").end (err, res) =>
      @selectedProject = I.fromJS JSON.parse(res.text)
      @trigger()

  getTasks: ->
    Request.get '/api/tasks'
    .end (err, res) =>
      @tasks = I.fromJS JSON.parse(res.text)
      @trigger()

  switchTaskState: (id) ->
    taskIndex = @tasks.findEntry((i) -> i.get('id') is id)?[0]
    @tasks = @tasks.updateIn([taskIndex, 'status_id'], (i) -> if i is 2 then 1 else 2)
    @trigger()

module.exports = Reflux.createStore store
