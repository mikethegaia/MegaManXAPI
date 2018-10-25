//Modules
const Promise = require('bluebird');
const path = require('path');
const fs = require('fs');
const dbconnection = require('../utils/dbconnection');
const upload = require('../utils/upload');

//File types allowed and storage paths
const allowedTypes = ['image/jpeg', 'image/png'];
const media = path.join(__dirname, '../media');
const media_weapons = path.join(media, '/weapons');

//Rules: creation of the last path and the file's name
const ruleLastDir = function(req)
{
    return path.join(media_weapons, '/' + req.body.game_id);
}
const ruleName = function(req)
{
    return req.body.name.replace(/\s/g, '');
}

//Insert weapon
/*exports.insertWeaponByGameOwnerWeakness = function (req, res)
{
    upload([media, media_weapons], ruleLastDir, ruleName, allowedTypes, 'image', req, res)
    .then( function()
    {
        if(req.imageError){
            return Promise.reject(req.imageError);
        }
        return Promise.using(getConnection(), function(connection)
        {

        });
    });
}*/