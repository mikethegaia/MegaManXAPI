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
    return path.join(media, '/weapons');
}
const ruleName = function(req)
{
    return req.body.name.replace(/\s/g, '');
}

//Get weapon by ID
exports.getWeaponByID = async function (req, res)
{
    try 
    {
        let db = dbconnection.query('CALL Q_Get_Weapon_By_ID(?)', [req.params.id]);
        let rows = await db;
        rows[0] = JSON.parse(JSON.stringify(rows[0]));  //Weapon
        rows[1] = JSON.parse(JSON.stringify(rows[1]));  //Game
        rows[2] = JSON.parse(JSON.stringify(rows[2]));  //Player
        rows[3] = JSON.parse(JSON.stringify(rows[3]));  //Boss
        rows[4] = JSON.parse(JSON.stringify(rows[4]));  //Damage Chart
        if (rows[0].length < 1) throw {type: 'NO_SUCH_ELEMENTS', message: 'There is no such weapon'};
        rows[0][0].games = rows[1];
        rows[0][0].games.forEach( game => game.damageChart = [] );
        rows[0][0].players = rows[2];
        rows[0][0].boss = rows[3];
        rows[4].forEach( wk => {
            wk.weakness = wk.weakness.data[0];
            rows[0][0].games.forEach( game => {
                if (wk.game_id === game.game_id) {
                    wkSans = wk;
                    delete wkSans.game_id;
                    game.damageChart.push(wkSans);
                }
            });
        });
        res.status(200).send({message: 'Success', errors : null, data : rows[0][0]});
    } catch (err)
    {
        let status = 500;
        console.log(err);
        if (err.type == 'NO_SUCH_ELEMENTS') status = 404; 
        res.status(500).send({message: 'Error in DB', errors : err, data : null});
    }
};

//Insert weapon (by boss)
exports.insertWeapon = async function (req, res)
{
    let boss_id;
    try
    {
        await upload([media], ruleLastDir, ruleName, allowedTypes, 'image', req, res);
        if (req.imageError) throw req.imageError;
        if (req.params.boss_id) boss_id = req.params.boss_id;
        else boss_id = 0;
        let db = dbconnection.query('CALL Q_Insert_Weapon(?,?,?)', [req.body.name, req.file.filename, boss_id]);
        let rows = await db;
        rows[0] = JSON.parse(JSON.stringify(rows[0]));
        if (rows[0][0].id <= 0) throw {type: 'NO_SUCH_ELEMENTS', message: rows[0][0].message};
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

//Assign weapon to player(s)
exports.assignWeaponPlayer = async function (req, res)
{
    let data = [];
    let players = req.params.player_ids.split(',');
    try
    {
        for (let i = 0; i<players.length; i++)
        {
            await dbconnection.query('CALL Q_Insert_Player_Weapon(?,?)', [players[i], req.params.weapon_id])
            .then(function (rows)
            {
                rows[0] = JSON.parse(JSON.stringify(rows[0]));
                if (rows[0][0].id <= 0) return Promise.reject({type: 'NO_SUCH_ELEMENTS', message: rows[0][0].message, player: parseInt(players[i])});
                rows[0][0].player_id = parseInt(players[i]);
                data.push(rows[0][0]);   
            });
        }

        res.status(201).send({message: data[0].message, errors : null, data : data});
    } catch (err)
    {
        let status = 500;
        console.log(err);
        if (err.type == 'NO_SUCH_ELEMENTS')
        {
            console.log(data);
            status = 404;
            Promise.map(data, function(m)
            {
                dbconnection.query('DELETE FROM rel_player_weapon WHERE rel_player_weapon_id = ?', [m.id]);
            });
        }
        res.status(status).send({message: 'Error in DB', errors : err, data : null});
    }
};

//Insert damage values
exports.insertDamageValues = async function (req, res)
{
    let charged_damage;
    try
    {
        if (req.body.charged_damage) charged_damage = req.body.charged_damage;
        else charged_damage = 0;
        let db = dbconnection.query('CALL Q_Insert_Boss_Weapon(?,?,?,?,?,?)', [req.params.boss_id, req.params.weapon_id, req.params.game_id, 
            req.body.base_damage, charged_damage, req.body.weakness]);
        let rows = await db;
        rows[0] = JSON.parse(JSON.stringify(rows[0]));
        if (rows[0][0].id <= 0) throw {type: 'NO_SUCH_ELEMENTS', message: rows[0][0].message};
        res.status(201).send({message: rows[0][0].message, errors : null, data : rows[0][0]});
    } catch (err)
    {
        console.log(err);
        res.status(500).send({message: 'Error in DB', errors : err, data : null});
    }
};
