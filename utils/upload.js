const Promise = require('bluebird');
const fs = require('fs');
const multer = require('multer');

const upload = function(dirs, ruleLastDir, ruleName, allowedTypes, attribute, req, res)
{
    let storage = multer.diskStorage(
        {
            destination: function(req, file, cb)
            {
                dirs.forEach(element => {
                    if (!fs.existsSync(element)) fs.mkdirSync(element);
                });
                if (!fs.existsSync(ruleLastDir(req))) fs.mkdirSync(ruleLastDir(req));
                cb(null, ruleLastDir(req));
            },
            filename: function(req, file, cb)
            {
                let name = file.originalname.split('.');
                cb(null, ruleName(req) + '-' + Date.now() + '.' + name[1]);
            }
        }
    );
    let uploadFile = multer(
        {
            storage: storage,
            fileFilter: function(req, file, cb)
            {
                if (allowedTypes.includes(file.mimetype)) cb(null, true);
                else {
                    req.imageError = { type: 'FILETYPE_NOT_ALLOWED', message: 'Allowed types: ' + allowedTypes };
                    cb(null, false);
                }
            }
        }
    ).single(attribute);

    return Promise.promisify(uploadFile)(req, res);
}

module.exports = upload;