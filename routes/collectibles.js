const express = require('express');
const router = express.Router();
const settings = require('../utils/settings');
const upload = require('../utils/upload');

const collectibleController = require('../controllers/collectibleController');

//Get collectible by ID
router.route('/:id').get(collectibleController.getCollectibleByID);

//Get armor by ID
router.route('/armor/:id').get(collectibleController.getArmorByID);

//Insert collectible by stage and game
router.route('/stage/:stage_id/game/:game_id')
    .post(upload([settings.UPLOAD.MEDIA, settings.UPLOAD.COLLECTIBLE]), collectibleController.insertCollectibleByStageGame);

//Insert armor
router.route('/armor')
    .post(upload([settings.UPLOAD.MEDIA, settings.UPLOAD.ARMOR]) ,collectibleController.insertArmor);

module.exports = router;