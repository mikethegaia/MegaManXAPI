//Modules
const Promise = require('bluebird');
const fs = require('fs');
const dbconnection = require('../utils/dbconnection');
const settings = require('../utils/settings');

//Get player by id
exports.getPlayerByID = async function (req, res)
{
    try 
    {
        let db = dbconnection.query(settings.QUERIES.GETPLAYER, [req.params.id]);
        let rows = await db;
        rows[0] = JSON.parse(JSON.stringify(rows[0]));  //Player
        rows[1] = JSON.parse(JSON.stringify(rows[1]));  //Main Weapons
        rows[2] = JSON.parse(JSON.stringify(rows[2]));  //Games
        if (rows[0].length < 1) throw {type: 'NO_SUCH_ELEMENTS', message: 'There is no such player'};
        rows[0][0].mainWeapons = JSON.parse(JSON.stringify(rows[1]));
        rows[0][0].games = JSON.parse(JSON.stringify(rows[2]));
        res.status(200).send({message: 'Success', errors : null, data : rows[0][0]});
    } catch (err)
    {
        let status = 500;
        console.log(err);
        if (err.type == 'NO_SUCH_ELEMENTS') status = 404; 
        res.status(status).send({message: 'Error in DB', errors : err, data : null});
    }
};

//Insert player by games
exports.insertPlayerByGames = async function (req, res)
{
    let data = []
    let player_id;
    let games = req.params.game_ids.split(',');
    try 
    {
        if (req.imageError) throw req.imageError;
        let db = dbconnection.query(settings.QUERIES.INSERTPLAYER, [req.body.name, req.body.description, req.body.gender, req.file.filename]);
        let rows = await db;
        rows[0] = JSON.parse(JSON.stringify(rows[0]));
        data.push(rows[0][0]);
        player_id = rows[0][0].id;

        await Promise.map(games, function(game)
        {
            return dbconnection.query(settings.QUERIES.INSERTGAMEPLAYER, [game, player_id])
            .then( function(rows)
            {
                rows[0] = JSON.parse(JSON.stringify(rows[0]));
                if (rows[0][0].id <= 0) return Promise.reject({type: 'NO_SUCH_ELEMENTS', message: rows[0][0].message, game: parseInt(game)});
                rows[0][0].game_id = parseInt(game);
                data.push(rows[0][0]);
            });
        });

        res.status(201).send({message: data[0].message, errors : null, data : data});

    } catch (err)
    {
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
                dbconnection.query(settings.QUERIES.DELETEBADPLAYERREQUEST, [player_id])
            }
            res.status(status).send({message: 'Error in DB', errors : err, data : null});
        }
    }
}