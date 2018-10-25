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
    return path.join(media, '/bosses');
}
const ruleName = function(req)
{
    return req.body.name.replace(/\s/g, '');
}

//Boss by id
exports.getBossByID = async function (req, res)
{
    try 
    {
        let db = dbconnection.query('CALL Q_Get_Boss_By_ID(?)', [req.params.id]);
        let rows = await db;
        rows[0] = JSON.parse(JSON.stringify(rows[0]));
        rows[0][0].infoPerGame = JSON.parse(JSON.stringify(rows[1]));
        res.status(200).send({message: 'Success', errors : null, data : rows[0][0]});
    } catch (err)
    {
        console.log(err);
        res.status(500).send({message: 'Error in DB', errors : err, data : null});
    }
};

//Insert boss
exports.insertBoss = async function (req, res)
{
    try 
    {
        await upload([media], ruleLastDir, ruleName, allowedTypes, 'image', req, res);
        if (req.imageError) throw req.imageError;
        let db = dbconnection.query('CALL Q_Insert_Boss(?,?,?)', [req.body.name, req.body.description, req.file.filename]);
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
};

//Insert boss in-game data
exports.insertInGameData = async function (req, res)
{
    try
    {
        let db = dbconnection.query('CALL Q_Insert_Game_Boss(?,?,?,?)', [req.params.game_id, req.params.boss_id, req.body.hp, req.body.stage_id]);
        let rows = await db;
        rows[0] = JSON.parse(JSON.stringify(rows[0]));
        if (rows[0][0].id <= 0)
        {
            throw {type: 'NO_SUCH_ELEMENTS', message: rows[0][0].message};
        }
        res.status(201).send({message: rows[0][0].message, errors : null, data : rows[0][0]});
    } catch (err)
    {
        console.log(err);
        res.status(500).send({message: 'Error in DB', errors : err, data : null});
    }
};