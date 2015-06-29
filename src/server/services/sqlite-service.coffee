sql = require 'sqlite3'
_ = require 'lodash'

class SQLite
  db: new sql.Database('./db.sqlite')
  getRecords: (cb) ->
    @db.all 'SELECT * FROM projects', (e, records) ->
      console.log 'records'
      cb(records)

  getRecord: (table, id, cb) ->
    console.log "SELECT * FROM #{table} WHERE id = #{id}"
    @db.all "SELECT * FROM #{table} WHERE id = #{id}", (e, records) ->
      console.log records
      if records? and records.length > 0
        cb(records[0])
      else
        cb(null)

  add: (table, record, cb) ->
    keys = Object.keys record
    values = keys.map (i) -> record[i]

    keysStr = keys.join(', ')
    valuesStr = values.map((i)-> "'#{i}'").join(', ')

    console.log "INSERT INTO #{table} (#{keysStr}) VALUES (#{valuesStr})"
    @db.run "INSERT INTO #{table} (#{keysStr}) VALUES (#{valuesStr})", cb


module.exports = new SQLite()
