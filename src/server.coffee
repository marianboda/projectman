express = require 'express'
bodyParser = require 'body-parser'
session = require 'express-session'
nodeUuid = require 'node-uuid'
passport = require 'passport'
GoogleStrategy = require('passport-google-oauth').OAuth2Strategy
db = require './server/services/sqlite-service'

app = express()
router = express.Router()
port = process.env.PORT || 3002
apiRouter = require './server/api-router'
config = require './server/config'

server = app.listen port, ->
  console.log 'App listening at %s : %s',
  server.address().address, server.address().port

app.use bodyParser.json()

passport.serializeUser (user, done) -> done null, user
passport.deserializeUser (obj, done) -> done null, obj
googleAuthVerify = (accessToken, refreshToken, profile, done) ->
  db.getRecord 'users', {google_id: profile.id}, (err) ->
    console.log 'sme dalej'

  setTimeout ( -> done(null, profile)), 0

passport.use new GoogleStrategy(config.GOOGLE_AUTH, googleAuthVerify)

app.use session
  genid: (req) -> nodeUuid.v4()
  secret: 'lahsbeioalijsrel'
app.use passport.initialize()
app.use passport.session()

router.get '/*', (req, res) ->
  res.sendFile(__dirname + '/client/index.html')
app.use '/static', express.static(__dirname + '/../static')

app.get '/auth/google', passport.authenticate('google', {scope: 'profile'})
app.get config.GOOGLE_AUTH.callbackURL, passport.authenticate('google', { failureRedirect: '/login' }),
  (req, res) -> res.redirect '/'

app.get '/logout', (req, res) ->
  req.logout()
  res.redirect '/'

app.use '/user', (req, res) ->
  console.log req.user
  res.send req.user

# app.use '/favicon.ico', express.static(__dirname + '/../static/favicon.ico')
# app.get '/*', (req, res, next) ->
#   console.log if req.user? then "user #{req.user}" else 'NOT LOGGED IN'
#   next()
app.use '/api', apiRouter
app.use '/', router
