express = require 'express'

app = express()
router = express.Router()
port = process.env.PORT || 3002

router.get '/', (req, res) ->
  # res.send ':)'
  res.sendFile(__dirname + '/client/index.html')

app.use '/static', express.static(__dirname + '/../static')
# app.use '/favicon.ico', express.static(__dirname + '/../static/favicon.ico')
app.use '/api', require('./ApiRouter')
app.use '/', router

console.log ':)'
server = app.listen port, ->
  console.log 'App listening at %s : %s',
    server.address().address, server.address().port
