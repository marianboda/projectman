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
    @db.get "SELECT * FROM #{table} WHERE id = ?", id, (e, record) ->
      console.log record
      cb(record)

  add: (table, record, cb) ->
    keys = Object.keys record
    values = keys.map (i) -> record[i]

    keysStr = keys.join(', ')
    valuesStr = values.map((i)-> "'#{i}'").join(', ')

    console.log "INSERT INTO #{table} (#{keysStr}) VALUES (#{valuesStr})"
    @db.run "INSERT INTO #{table} (#{keysStr}) VALUES (#{valuesStr})", cb

  getTables: (cb) ->
    @db.all "SELECT * FROM sqlite_master WHERE type='table'", (e, records) ->
      console.log 'records', records
      cb(records)

module.exports = new SQLite()
