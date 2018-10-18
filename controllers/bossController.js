const getConnection = require('../utils/dbconnection');
const Promise = require('bluebird');

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
        //res.json({ code : 0, message : 'Success', boss : rows[0][0] });
        res.status(200).send({message: 'Success', errors : null, data : rows[0][0]});
    }).catch( function (err)
    {
        console.log(err);
        //res.json({ code : 404, message : 'Error in DB' });
        res.status(500).send({message: 'Error in DB', errors : err, data : null});
    });
};