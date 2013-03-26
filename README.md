# zappa-auth
Boilerplate to create basic login authentication in Zappa/ NodeJS with MySQL

## Tutorial
### Follow the step-by-step tutorial on [cryptoguru.com](http://cryptoguru.com/posts/nodejs/user_auth)

## Usage
### Set the MySQL login details in 'models/mysql.coffee'
``` coffeescript
mysql_model = require 'mysql-model'
conn = mysql_model.createConnection
    host: "HOSTNAME"
    user: "USERNAME"
    password: "PASSWORD"
    database: "DATABASE"

@User = conn.extend tableName: "users"
@user = new conn tableName: "users"
@Mysql = new conn()
```
