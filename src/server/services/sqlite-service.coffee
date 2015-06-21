sql = require 'sqlite3'

class SQLite
  db: new sql.Database('./db.sqlite')
  getRecords: (cb) ->
    @db.all 'SELECT * FROM projects', (e, records) ->
      console.log 'records'
      cb(records)


module.exports = new SQLite()
