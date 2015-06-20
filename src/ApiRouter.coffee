apiRouter = require('express').Router()

apiRouter.get '/*', (req, res, next) ->
  console.log 'calling router'
  res.send JSON.stringify({a: '22', b: '42'})

module.exports = apiRouter
