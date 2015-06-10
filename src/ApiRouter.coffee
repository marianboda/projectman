apiRouter = require('express').Router()

apiRouter.get '/', (req, res, next) ->
  res.send 'inside api router'

module.exports = apiRouter
