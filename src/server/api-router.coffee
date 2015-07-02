apiRouter = require('express').Router()
Sqlite = require './services/sqlite-service'

apiRouter.get '/projects', (req, res, next) ->
  req.session.apiCalls ?= 0
  console.log 'calling router > projects' + req.session.apiCalls
  req.session.apiCalls++
  Sqlite.getRecords (recs) ->
    res.send recs

apiRouter.post '/projects', (req, res, next) ->
  console.log 'calling router > projects', req.body
  rec = req.body
  Sqlite.add 'projects', rec, (result) ->
    res.send result

apiRouter.get '/projects/:id', (req, res, next) ->
  console.log 'calling router > project > ' + req.params.id
  Sqlite.getRecord 'projects', req.params.id, (result) ->
    res.send result

apiRouter.get '/tables', (req, res, next) ->
  console.log 'calling router > tables > '
  Sqlite.getTables (result) ->
    res.send result

module.exports = apiRouter
