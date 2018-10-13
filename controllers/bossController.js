var db = require('../models/dbconnection');
var Boss = require('../models/bossModel');

exports.getBosses = function (req, res)
{
    db.query('SELECT * FROM boss', function(err, results)
        {
            if (err) {
                res.json('Error in DB');
            } else {
                let rows = JSON.parse(JSON.stringify(results));
                let bosses = new Array();
                rows.forEach(function(row)
                {
                    let boss = new Boss(row.boss_id, row.b_name, row.hp);
                    bosses.push(boss);
                });
                res.json(bosses);
            }
        }
    );
};

exports.getBossByID = function (req, res)
{
    db.query('SELECT * FROM boss WHERE boss_id = ' + req.params.id, function(err, results)
    {
        if (err)
        {
            res.json('Error in DB');
        } else {
            let rows = JSON.parse(JSON.stringify(results));
            console.log(rows);
            let boss = new Boss(rows[0].boss_id, rows[0].b_name, rows[0].hp);
            res.json(boss);
        }
    });
};

exports.getBossByGame = function(req, res)
{
    db.query('select boss.boss_id, b_name, hp from boss '
     + 'inner join rel_game_boss on boss.boss_id = rel_game_boss.boss_id '
     + 'where rel_game_boss.game_id = ' + req.params.id, function(err, results)
        {
            if (err) {
                res.json('Error in DB');
            } else {
                let rows = JSON.parse(JSON.stringify(results));
                let bosses = new Array();
                rows.forEach(function(row)
                {
                    let boss = new Boss(row.boss_id, row.b_name, row.hp);
                    bosses.push(boss);
                });
                res.json(bosses);
            }
        }
    );
}

exports.addBoss = function(req, res)
{
    let boss = new Boss(0, req.body.name, req.body.hp);
    db.query('insert into boss (b_name, hp) values (\'' 
        + boss.name + '\', ' + boss.hp + ')', function(err, results)
        {
            if (err)
            {
                console.log(err);
                res.json('Error in DB');
            } else {
                res.json({
                    message: 'Success',
                    code : 0
                });
            }
        });
};
