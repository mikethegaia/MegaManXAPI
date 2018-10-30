//Modules
const Promise = require('bluebird');
const path = require('path');
const fs = require('fs');
const dbconnection = require('../utils/dbconnection');
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
exports.getGameByID = async function (req, res)
{
    try 
    {
        let db = dbconnection.query('CALL Q_Get_Game_By_ID(?)', [req.params.id]);
        let rows = await db;
        rows[0] = JSON.parse(JSON.stringify(rows[0]));  // Game
        rows[1] = JSON.parse(JSON.stringify(rows[1]));  // Characters
        rows[2] = JSON.parse(JSON.stringify(rows[2]));  // Armor sets
        rows[3] = JSON.parse(JSON.stringify(rows[3]));  // Weakness chart
        if (rows[0].length < 1) throw {type: 'NO_SUCH_ELEMENTS', message: 'There is no such game'};
        rows[0][0].platforms = JSON.parse(rows[0][0].platforms);
        rows[0][0].players = rows[1];
        //rows[0][0].armors = rows[2];
        rows[0][0].weakness_chart = rows[2];
        res.status(200).send({message: 'Success', errors : null, data : rows[0][0]});
    } catch (err) 
    {
        let status = 500;
        console.log(err);
        if (err.type == 'NO_SUCH_ELEMENTS') status = 404; 
        res.status(500).send({message: 'Error in DB', errors : err, data : null});
    }
}

//Insert game
exports.insertGame = async function (req, res)
{
    try
    {
        await upload([media], ruleLastDir, ruleName, allowedTypes, 'image', req, res);
        if (req.imageError) throw req.imageError;
        let db = dbconnection.query('CALL Q_Insert_Game(?,?,?,?,?)', [req.body.title, req.body.release_date, req.body.story,req.body.platforms, req.file.filename]);
        let rows = await db;
        rows[0] = JSON.parse(JSON.stringify(rows[0]));
        res.status(201).send({message: 'Success', errors : null, data : rows[0][0]});
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
