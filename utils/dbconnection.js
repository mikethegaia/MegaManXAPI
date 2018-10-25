const Promise = require('bluebird');
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

function query(sqlQuery, sqlData){
    return Promise.using(getConnection(), function(connection)
    {
        return connection.query(sqlQuery, sqlData);
    });
}

exports.getConnection = getConnection;
exports.query = query;