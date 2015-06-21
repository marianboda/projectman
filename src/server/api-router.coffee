apiRouter = require('express').Router()
Sqlite = require './services/sqlite-service'

apiRouter.get '/projects', (req, res, next) ->
  console.log 'calling router > projects'
  Sqlite.getRecords (recs) ->
    res.send recs
    # res.send JSON.stringify [
    #   {
    #     name: 'project 1'
    #     type: 'default'
    #   }
    #   {
    #     name: 'Photor'
    #     type: 'extra'
    #   }
    # ]

module.exports = apiRouter
