const mysql = require('promise-mysql');

const pool = mysql.createPool({
    host: process.env.MYSQLHOST,
    user: process.env.MYSQLUSER,
    password: process.env.MYSQLPASS,
    database: process.env.MYSQLDB
});

function getConnection(){
    return pool.getConnection().disposer(function(connection)
    {
        pool.releaseConnection(connection);
    });
}

module.exports = getConnection;