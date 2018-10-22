//Modules
const Promise = require('bluebird');
const path = require('path');
const fs = require('fs');
const getConnection = require('../utils/dbconnection');
const upload = require('../utils/upload');

//File types allowed and storage paths
const allowedTypes = ['image/jpeg', 'image/png'];
const media = path.join(__dirname, '../media');

//Rules: creation of the last path and the file's name
const ruleLastDir = function(req)
{
    return path.join(media, '/games');
}
const ruleName = function(req)
{
    return req.body.title.replace(/\s/g, '');
}

//Game by id
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

//Insert game
exports.insertGame = function (req, res)
{
    upload([media], ruleLastDir, ruleName, allowedTypes, 'image', req, res)
    .then( function()
    {
        if(req.imageError){
            return Promise.reject(req.imageError);
        }
        return Promise.using(getConnection(), function(connection)
        {
            let sqlQuery = 'CALL Q_Insert_Game(?,?,?,?,?)';
            let sqlData = [req.body.title, req.body.release_date, req.body.story, JSON.stringify(req.body.platforms), req.file.filename];
            return connection.query(sqlQuery, sqlData);
        });
    })
    .then( function(rows)
    {
        rows[0] = JSON.parse(JSON.stringify(rows[0]));
        res.status(200).send({message: 'Success', errors : null, data : rows[0][0]});
    }).catch( function (err)
    {
        console.log(err);
        if(err.type == 'FILETYPE_NOT_ALLOWED') res.status(415).send({ message: req.imageError.message, errors: req.imageError, data: null });
        else {
            fs.unlink(req.file.path, function(err){
                console.log(err);
            });
            res.status(500).send({message: 'Error in DB', errors : err, data : null});
        }
    });
}
