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
    return path.join(media, '/players');
}
const ruleName = function(req)
{
    return req.body.name.replace(/\s/g, '');
}

//Insert player by games
exports.insertPlayerByGames = function (req, res)
{
    let data = [];
    let player_id;
    upload([media], ruleLastDir, ruleName, allowedTypes, 'image', req, res)
    .then( function()
    {
        if(req.imageError){
            return Promise.reject(req.imageError);
        }
        return Promise.using(getConnection(), function(connection)
        {
            let sqlQuery = 'CALL Q_Insert_Player(?,?,?,?)';
            let sqlData = [req.body.name, req.body.description, req.body.gender, req.file.filename];
            return connection.query(sqlQuery, sqlData);
        });
    })
    .then( function(rows)
    {
        rows[0] = JSON.parse(JSON.stringify(rows[0]));
        data.push(rows[0][0]);
        player_id = rows[0][0].id;
        let games = req.params.game_ids.split(',');
        return Promise.map(games, function(game)
        {
            return Promise.using(getConnection(), function(connection)
            {
                let sqlQuery = 'CALL Q_Insert_Game_Player(?,?)';
                let sqlData = [game, player_id];
                return connection.query(sqlQuery, sqlData);
            })
            .then( function(rows)
            {
                rows[0] = JSON.parse(JSON.stringify(rows[0]));
                if (rows[0][0].id <= 0)
                {
                    return Promise.reject({type: 'NO_SUCH_ELEMENTS', message: rows[0][0].message, game: parseInt(game)});
                }
                rows[0][0].game_id = parseInt(game);
                data.push(rows[0][0]);
            });
        });
    })
    .then(function ()
    {
        res.status(201).send({message: data[0].message, errors : null, data : data});
    })
    .catch( function(err){
        let status = 500;
        console.log(err);
        if(err.type == 'FILETYPE_NOT_ALLOWED') res.status(415).send({ message: req.imageError.message, errors: req.imageError, data: null });
        else {
            fs.unlink(req.file.path, function(err){
                console.log(err);
            });
            if (err.type == 'NO_SUCH_ELEMENTS')
            {
                status = 404;
                Promise.using(getConnection(), function(connection)
                {
                    let sqlQuery = 'DELETE FROM player WHERE player_id = ?';
                    let sqlData = [player_id];
                    return connection.query(sqlQuery, sqlData);
                })
            }
            res.status(status).send({message: 'Error in DB', errors : err, data : null});
        }
    });
}