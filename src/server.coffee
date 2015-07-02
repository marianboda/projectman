express = require 'express'
everyauth = require 'everyauth'
bodyParser = require 'body-parser'
session = require 'express-session'
nodeUuid = require 'node-uuid'

app = express()
router = express.Router()
port = process.env.PORT || 3002
apiRouter = require './server/api-router'
config = require './server/config'

everyauth.google
.appId config.GOOGLE_CLIENT_ID
.appSecret config.GOOGLE_SECRET
.scope 'profile'
.handleAuthCallbackError (req, res) -> console.log 'some err'
.getSession (req) ->
  req.session
.findOrCreateUser (session, accessToken, accessTokenExtra, googleUserMetadata) ->
  console.log session, accessToken, accessTokenExtra, googleUserMetadata
  session.user = googleUserMetadata
  {user: ':)))'}
.redirectPath '/sranda?pp'
.entryPath '/goog'
.callbackPath('/')

app.use bodyParser.json()

router.get '/*', (req, res) ->
  res.sendFile(__dirname + '/client/index.html')

app.use everyauth.middleware()
app.use session
  genid: (req) -> nodeUuid.v4()
  secret: 'priepustka'
app.use '/static', express.static(__dirname + '/../static')
# app.use '/favicon.ico', express.static(__dirname + '/../static/favicon.ico')
app.use '/api', apiRouter
app.use '/', router

server = app.listen port, ->
  console.log 'App listening at %s : %s',
  server.address().address, server.address().port
