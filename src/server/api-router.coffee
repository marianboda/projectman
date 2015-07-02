apiRouter = require('express').Router()
Sqlite = require './services/sqlite-service'

apiRouter.get '/app-state', (req, res, next) ->
  res.send req.session.passport?.user ? {}

apiRouter.get '/projects', (req, res, next) ->
  req.session.apiCalls ?= 0
  # console.log 'calling router > projects ' + JSON.stringify(req.session)
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
