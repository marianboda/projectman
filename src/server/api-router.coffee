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

module.exports = apiRouter
