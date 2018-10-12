var mysql = require('mysql');
var port = process.env.PORT || 4205;

if (port === 4205)
{
    var connection = mysql.createConnection({
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: 'admin123',
        database: 'megamanx'
    });
} else {

    //live server

}

connection.connect();

module.exports = connection;