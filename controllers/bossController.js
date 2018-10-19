const getConnection = require('../utils/dbconnection');
const Promise = require('bluebird');
const path = require('path');
const fs = require('fs');
const multer = require('multer');
const uploadImage = multer({
    dest: path.join(__dirname, '../media'),
    fileFilter: function (req, file, cb){
        if (file.mimetype == 'image/jpeg' || file.mimetype == 'image/png')
        {
            cb(null, true);    
        } else {
            req.imageError = { type: 'FILETYPE_NOT_ALLOWED', message: 'Only .jpeg or .png files are allowed' };
            cb(null, false);
        }
    }}).single('image');

exports.getBossByID = function (req, res)
{
    Promise.using(getConnection(), function(connection)
    {
        let sqlQuery = 'CALL Q_Get_Boss_By_ID(?)';
        let sqlData = [req.params.id];
        return connection.query(sqlQuery, sqlData);
    }).then( function (rows)
    {
        rows[0] = JSON.parse(JSON.stringify(rows[0]));
        res.status(200).send({message: 'Success', errors : null, data : rows[0][0]});
    }).catch( function (err)
    {
        console.log(err);
        res.status(500).send({message: 'Error in DB', errors : err, data : null});
    });
};

exports.insertBossByGame = function (req, res)
{
    if (!fs.existsSync(path.join(__dirname, '../media'))) 
    {
		fs.mkdirSync(path.join(__dirname, '../media'));
	}
    Promise.promisify(uploadImage)(req, res)
        .then( function () {
            if(req.imageError){
                return Promise.reject(req.imageError);
            }
            return Promise.using(getConnection(), function(connection)
            {
                let sqlQuery = 'CALL Q_Insert_Boss_By_Game(?,?,?,?,?,?)';
                let sqlData = [req.body.name, req.body.description, req.body.hp, req.body.stage, req.file.originalname, req.body.game_id];
                return connection.query(sqlQuery, sqlData);
            });
        })
        .then( function(rows)
        {
            rows[0] = JSON.parse(JSON.stringify(rows[0]));
            res.status(200).send({message: 'Success', errors : null, data : rows[0][0]});
        })
        .catch( function(err){
            console.log(err);
            if(err.type == 'FILETYPE_NOT_ALLOWED') res.status(415).send({ message: req.imageError.message, errors: req.imageError, data: null });
            else res.status(500).send({message: 'Error in DB', errors : err, data : null});
        });
}