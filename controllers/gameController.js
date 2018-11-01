//Modules
const fs = require('fs');
const dbconnection = require('../utils/dbconnection');
const settings = require('../utils/settings');

//Game by id
exports.getGameByID = async function (req, res)
{
    try 
    {
        let db = dbconnection.query(settings.QUERIES.GETGAME, [req.params.id]);
        let rows = await db;
        rows[0] = JSON.parse(JSON.stringify(rows[0]));  // Game
        rows[1] = JSON.parse(JSON.stringify(rows[1]));  // Players
        rows[2] = JSON.parse(JSON.stringify(rows[2]));  // Stages
        rows[3] = JSON.parse(JSON.stringify(rows[3]));  // Armors
        rows[4] = JSON.parse(JSON.stringify(rows[4]));  // Weakness chart
        if (rows[0].length < 1) throw {type: 'NO_SUCH_ELEMENTS', message: 'There is no such game'};
        rows[0][0].platforms = JSON.parse(rows[0][0].platforms);
        rows[0][0].players = rows[1];
        rows[0][0].stages = rows[2];
        let armors = rows[3].map(armor => {
            let nArmor = {x_armor_id : armor.x_armor_id,
                name : armor.name,
                image : armor.image};
            let head = {head_id : armor.head_id,
                name : armor.head,
                image : armor.head_image};
            let body = {body_id : armor.body_id,
                name : armor.body,
                image : armor.body_image};
            let arm = {arm_id : armor.arm_id,
                name : armor.arm,
                image : armor.arm_image};
            let foot = {foot_id : armor.foot_id,
                name : armor.foot,
                image : armor.foot_image};
            nArmor.head = head;
            nArmor.body = body;
            nArmor.arm = arm;
            nArmor.foot = foot;
            return nArmor;
        });
        rows[0][0].armor = armors;
        rows[0][0].weaknessChart = rows[4];
        res.status(200).send({message: 'Success', errors : null, data : rows[0][0]});
    } catch (err) 
    {
        let status = 500;
        console.log(err);
        if (err.type == 'NO_SUCH_ELEMENTS') status = 404; 
        res.status(status).send({message: 'Error in DB', errors : err, data : null});
    }
}

//Insert game
exports.insertGame = async function (req, res)
{
    try
    {
        if (req.imageError) throw req.imageError;
        let db = dbconnection.query(settings.QUERIES.INSERTGAME, [req.body.title, req.body.release_date, req.body.story,req.body.platforms, req.file.filename]);
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
