//Modules
const Promise = require('bluebird');
const path = require('path');
const fs = require('fs');
const dbconnection = require('../utils/dbconnection');
const upload = require('../utils/upload');
const settings = require('../utils/settings');

//File types allowed and storage paths
const allowedTypes = ['image/jpeg', 'image/png'];
const media = path.join(__dirname, '../media');

//Rules: creation of the last path and the file's name
const ruleLastDir = function(req)
{
    return path.join(media, '/stages');
}
const ruleName = function(req)
{
    return req.body.name.replace(/\s/g, '');
}

//Get stage by ID
exports.getStageByID = async function (req, res)
{
    try
    {
        let db = dbconnection.query(settings.QUERIES.GETSTAGE, [req.params.id]);
        let rows = await db;
        rows[0] = JSON.parse(JSON.stringify(rows[0]));  //Stage
        rows[1] = JSON.parse(JSON.stringify(rows[1]));  //Boss
        rows[2] = JSON.parse(JSON.stringify(rows[2]));  //Games
        rows[3] = JSON.parse(JSON.stringify(rows[3]));  //Collectibles
        if (rows[0].length < 1) throw {type: 'NO_SUCH_ELEMENTS', message: 'There is no such stage'};
        rows[0][0].boss = rows[1];
        rows[0][0].games = rows[2];
        rows[0][0].games.forEach( game => game.collectibles = [] );
        rows[3].forEach( collectible => {
            rows[0][0].games.forEach( game => {
                if (collectible.game_id === game.game_id)
                {
                    collectibleSans = collectible;
                    delete collectibleSans.game_id;
                    game.collectibles.push(collectibleSans);
                }
            });
        });
        res.status(200).send({message: 'Success', errors : null, data : rows[0][0]});
    } catch (err)
    {
        let status = 500;
        console.log(err);
        if (err.type == 'NO_SUCH_ELEMENTS') status = 404; 
        res.status(status).send({message: 'Error in DB', errors : err, data : null});
    }
}

//Insert stage

exports.insertStage = async function (req, res)
{
    try 
    {
        await upload([media], ruleLastDir, ruleName, allowedTypes, 'image', req, res);
        if (req.imageError) throw req.imageError;
        let db = dbconnection.query(settings.QUERIES.INSERTSTAGE, [req.body.name, req.body.description, req.file.filename]);
        let rows = await db;
        rows[0] = JSON.parse(JSON.stringify(rows[0]));
        if (rows[0][0].id <= 0) throw {type: 'NO_SUCH_ELEMENTS', message: rows[0][0].message};
        res.status(201).send({message: rows[0][0].message, errors : null, data : rows[0][0]});
    } catch (err)
    {
        console.log(err);
        if(err.type == 'FILETYPE_NOT_ALLOWED') res.status(415).send({ message: req.imageError.message, errors: req.imageError, data: null });
        else {
            fs.unlink(req.file.path, function(err){
                console.log(err);
            });
            res.status(500).send({message: 'Error in DB', errors : err, data : null});
        }
    }
}