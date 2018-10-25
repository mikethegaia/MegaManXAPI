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
    return path.join(media, '/stages');
}
const ruleName = function(req)
{
    return req.body.name.replace(/\s/g, '');
}

//Insert stage

exports.insertStage = function (req, res)
{
    upload([media], ruleLastDir, ruleName, allowedTypes, 'image', req, res)
    .then( function () 
    {
        if(req.imageError){
            return Promise.reject(req.imageError);
        }
        return dbconnection.query('CALL Q_Insert_Stage(?,?,?)', [req.body.name, req.body.description, req.file.filename]);
    })
    .then( function(rows)
    {
        rows[0] = JSON.parse(JSON.stringify(rows[0]));
        if (rows[0][0].id <= 0)
        {
            return Promise.reject({type: 'NO_SUCH_ELEMENTS', message: rows[0][0].message});
        }
        res.status(201).send({message: rows[0][0].message, errors : null, data : rows[0][0]});
    })
    .catch( function(err){
        console.log(err);
        if(err.type == 'FILETYPE_NOT_ALLOWED') res.status(415).send({ message: req.imageError.message, errors: req.imageError, data: null });
        else {
            fs.unlink(req.file.path, function(err){
                console.log(err);
            });
            res.status(500).send({message: 'Error in DB', errors : err, data : null});
        }
    });
}