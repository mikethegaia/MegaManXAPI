const getConnection = require('../utils/dbconnection');
const Promise = require('bluebird');

exports.insertGame = function (req, res)
{
    Promise.using(getConnection(), function(connection)
    {
        let sqlQuery = 'CALL Q_Insert_Game(?,?,?,?)';
        let sqlData = [req.body.title, req.body.release_date, req.body.story, JSON.stringify(req.body.platforms)];
        return connection.query(sqlQuery, sqlData);
    }).then( function(rows){
        rows[0] = JSON.parse(JSON.stringify(rows[0]));
        res.status(200).send({message: 'Success', errors : null, data : rows[0][0]});
    }).catch( function (err)
    {
        console.log(err);
        res.status(500).send({message: 'Error in DB', errors : err, data : null});
    });
}

exports.getGameByID = function (req, res)
{
    Promise.using(getConnection(), function(connection){
        let sqlQuery = 'CALL Q_Get_Game_By_ID(?)';
        let sqlData = [req.params.id];
        return connection.query(sqlQuery, sqlData);
    }).then( function (rows)
    {
        rows[0] = JSON.parse(JSON.stringify(rows[0]));  // Game
        rows[1] = JSON.parse(JSON.stringify(rows[1]));  // Characters
        rows[2] = JSON.parse(JSON.stringify(rows[2]));  // Armor sets
        rows[3] = JSON.parse(JSON.stringify(rows[3]));  // Weakness chart

        rows[0][0].platforms = JSON.parse(rows[0][0].platforms);
        rows[0][0].players = rows[1];
        rows[0][0].armors = rows[2];
        rows[0][0].weakness_chart = rows[3];

        res.status(200).send({message: 'Success', errors : null, data : rows[0][0]});
    }).catch( function (err)
    {
        console.log(err);
        res.status(500).send({message: 'Error in DB', errors : err, data : null});
    });
}