apiRouter = require('express').Router()

apiRouter.get '/projects', (req, res, next) ->
  console.log 'calling router > projects'
  res.send JSON.stringify [
    {
      name: 'project 1'
      type: 'default'
    }
    {
      name: 'Photor'
      type: 'extra'
    }
  ]

module.exports = apiRouter
