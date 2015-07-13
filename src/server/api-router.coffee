apiRouter = require('express').Router()
Sqlite = require './services/sqlite-service'

apiRouter.get '/app-state', (req, res, next) ->
  res.send req.session.passport?.user ? {}

apiRouter.get '/projects', (req, res, next) ->
  Sqlite.getRecords 'projects', {}, (recs) ->
    res.send recs

apiRouter.post '/projects', (req, res, next) ->
  rec = req.body
  Sqlite.add 'projects', rec, (result) ->
    res.send result

apiRouter.get '/projects/:id', (req, res, next) ->
  Sqlite.getRecord 'projects', req.params.id, (result) ->
    res.send result

apiRouter.get '/tasks', (req, res, next) ->
  req.session.apiCalls++
  Sqlite.getRecords 'tasks', {}, (recs) ->
    res.send recs

apiRouter.post '/tasks', (req, res, next) ->
  rec = req.body
  Sqlite.add 'tasks', rec, (result) ->
    res.send result

apiRouter.get '/tables', (req, res, next) ->
  console.log 'calling router > tables > '
  Sqlite.getTables (result) ->
    res.send result

module.exports = apiRouter
