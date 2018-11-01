const fs = require('fs');
const multer = require('multer');
const settings = require('../utils/settings');

const upload = function(dirs)
{
    let ruleName = settings.UPLOAD.RULENAME;
    let allowedTypes = settings.UPLOAD.ALLOWEDTYPES;
    let attribute = settings.UPLOAD.ATTRIBUTE;

    let storage = multer.diskStorage({
        destination: function(req, file, cb)
        {
            dirs.forEach(element => {
                if (!fs.existsSync(element)) fs.mkdirSync(element);
            });
            cb(null, dirs[dirs.length-1]);
        },
        filename: function(req, file, cb)
        {
            let name = file.originalname.split('.');
            cb(null, ruleName(req, name[1]));
        }
    });

    let uploadFile = multer({
        storage: storage,
        fileFilter: function(req, file, cb)
        {
            if (allowedTypes.includes(file.mimetype)) cb(null, true);
            else {
                req.imageError = { type: 'FILETYPE_NOT_ALLOWED', message: 'Allowed types: ' + allowedTypes };
                cb(null, false);
            }
        }
    }).single(attribute);

    return uploadFile;
}

module.exports = upload;