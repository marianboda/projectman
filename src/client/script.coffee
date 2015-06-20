request = require 'superagent'

request.get 'api/all'
.end (err, res) ->
  console.log 'I\'m back', res
  o = JSON.parse res.text

  for k,v of o
    console.log "#{k} = #{v}"
