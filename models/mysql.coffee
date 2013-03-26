mysql_model = require 'mysql-model'
conn = mysql_model.createConnection
  host: "database-host"
  user: "database-user"
  password: "database-password"
  database: "database"

@User = conn.extend tableName: "users"
@user = new conn tableName: "users"
@Mysql = new conn()
