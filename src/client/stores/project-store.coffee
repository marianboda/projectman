I = require 'immutable'
Reflux = require 'reflux'
Request = require 'superagent'

store =
  projects: I.Set [

  ]

  init: ->

    Request.get 'api/projects'
    .end (err, res) =>
      console.log 'I\'m back', res
      @projects = I.fromJS JSON.parse(res.text)
      @trigger()

  getProjects: ->

module.exports = Reflux.createStore store
