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
const ruleLastDirCollectible = function(req)
{
    return path.join(media, '/collectibles');
}
const ruleLastDirArmor = function(req)
{
    return path.join(media, '/armors');
}
const ruleName = function(req)
{
    return req.body.name.replace(/\s/g, '');
}

//Get collectible by Id
exports.getCollectibleByID = async function (req, res)
{
    try
    {
        let db = dbconnection.query('CALL Q_Get_Collectible_By_ID(?)', [req.params.id]);
        let rows = await db;
        rows[0] = JSON.parse(JSON.stringify(rows[0]));  //Collectible
        if (rows[0].length < 1) throw {type: 'NO_SUCH_ELEMENTS', message: 'There is no such collectible'};
        res.status(200).send({message: 'Success', errors : null, data : rows[0][0]});
    } catch (err)
    {
        let status = 500;
        console.log(err);
        if (err.type == 'NO_SUCH_ELEMENTS') status = 404; 
        res.status(status).send({message: 'Error in DB', errors : err, data : null});
    }
};

//Get armor by ID
exports.getArmorByID = async function (req, res)
{
    try 
    {
        let db = dbconnection.query('CALL Q_Get_Armor_By_ID(?)', [req.params.id]);
        let rows = await db;
        rows[0] = JSON.parse(JSON.stringify(rows[0]));  //Armor
        rows[1] = JSON.parse(JSON.stringify(rows[1]));  //Games
        rows[2] = JSON.parse(JSON.stringify(rows[2]));  //Head
        rows[3] = JSON.parse(JSON.stringify(rows[3]));  //Body
        rows[4] = JSON.parse(JSON.stringify(rows[4]));  //Arm
        rows[5] = JSON.parse(JSON.stringify(rows[5]));  //Foot
        if (rows[0].length < 1) throw {type: 'NO_SUCH_ELEMENTS', message: 'There is no such armor'};
        rows[0][0].games = JSON.parse(JSON.stringify(rows[1]));
        rows[0][0].head = JSON.parse(JSON.stringify(rows[2]));
        rows[0][0].body = JSON.parse(JSON.stringify(rows[3]));
        rows[0][0].arm = JSON.parse(JSON.stringify(rows[4]));
        rows[0][0].foot = JSON.parse(JSON.stringify(rows[5]));
        res.status(200).send({message: 'Success', errors : null, data : rows[0][0]});
    } catch (err)
    {
        let status = 500;
        console.log(err);
        if (err.type == 'NO_SUCH_ELEMENTS') status = 404; 
        res.status(status).send({message: 'Error in DB', errors : err, data : null});
    }
};

//Insert collectible by stage and game
exports.insertCollectibleByStageGame = async function (req, res)
{
    try
    {
        await upload([media], ruleLastDirCollectible, ruleName, allowedTypes, 'image', req, res);
        if (req.imageError) throw req.imageError;
        let db = dbconnection.query('CALL Q_Insert_Collectible(?,?,?,?,?)', [req.body.name, req.body.description, req.file.filename, req.params.stage_id, req.params.game_id]);
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
};

//Insert armor
exports.insertArmor = async function (req, res)
{
    try
    {
        await upload([media], ruleLastDirArmor, ruleName, allowedTypes, 'image', req, res);
        if (req.imageError) throw req.imageError;
        let db = dbconnection.query('CALL Q_Insert_Armor(?,?,?,?,?,?)', [req.body.name, req.body.head, req.body.body, req.body.arm, req.body.foot, req.file.filename]);
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
};