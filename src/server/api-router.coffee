apiRouter = require('express').Router()
Sqlite = require './services/sqlite-service'

apiRouter.get '/projects', (req, res, next) ->
  console.log 'calling router > projects'
  Sqlite.getRecords (recs) ->
    res.send recs

apiRouter.post '/projects', (req, res, next) ->
  console.log 'calling router > projects', req.body
  rec = req.body
  Sqlite.add 'projects', rec, (result) ->
    res.send result

apiRouter.get '/projects/:id', (req, res, next) ->
  console.log 'calling router > project > ' + req.params.id#, req.body
  Sqlite.getRecord 'projects', req.params.id, (result) ->
    res.send result

apiRouter.get '/tables', (req, res, next) ->
  console.log 'calling router > tables > '
  Sqlite.getTables (result) ->
    console.log result
    res.send result

module.exports = apiRouter
