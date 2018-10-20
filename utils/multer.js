const Promise = require('bluebird');
const fs = require('fs');
const upload = require('');

var multer = function (dir, file_req, filter, req, res)
{
    let storage = upload.diskStorage({
        destination: function(req, file, cb)
        {
            if(!fs.existsSync(dir)) fs.mkdirSync(dir);
            cb(null, dir);
        },
        filename: function(req, file, cb)
        {
            let name = file.originalname.split('.');
            cb(null, req.body.name.trim() + '-' + Date.now() + '.' + name[1]);
        }
    });
    let u = multer({
        storage: storage,
        fileFilter: filter
    }).single(file_req);
    return Promise.promisify(multer)(req, res);
}

module.exports = multer;