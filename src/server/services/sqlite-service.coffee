sql = require 'sqlite3'
_ = require 'lodash'

class SQLite
  db: new sql.Database('./db.sqlite')
  getRecords: (cb) ->
    @db.all 'SELECT * FROM projects', (e, records) ->
      console.log 'records'
      cb(records)

  add: (table, record, cb) ->
    keys = Object.keys record
    values = keys.map (i) -> record[i]

    keysStr = keys.join(', ')
    valuesStr = values.map((i)-> "'#{i}'").join(', ')

    console.log "INSERT INTO #{table} (#{keysStr}) VALUES (#{valuesStr})"
    @db.run "INSERT INTO #{table} (#{keysStr}) VALUES (#{valuesStr})", cb


module.exports = new SQLite()
