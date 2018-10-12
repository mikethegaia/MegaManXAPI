var mysql = require('mysql');
var port = process.env.PORT || 4205;

if (port === 4205)
{
    var connection = mysql.createConnection({
        host: process.env.MYSQLHOST,
        port: process.env.MYSQLPORT,
        user: process.env.MYSQLUSER,
        password: process.env.MYSQLPASS,
        database: process.env.MYSQLDB
    });
} else {

    //live server

}

connection.connect();

module.exports = connection;