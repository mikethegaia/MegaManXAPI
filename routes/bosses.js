const express = require('express');
const router = express.Router();
const settings = require('../utils/settings');
const upload = require('../utils/upload');

const bossController = require('../controllers/bossController');

//Boss by id
router.route('/:id').get(bossController.getBossByID);

//Insert boss
router.route('/')
    .post(upload([settings.UPLOAD.MEDIA, settings.UPLOAD.BOSS]), bossController.insertBoss);

//Insert boss in-game data
router.route('/:boss_id/game/:game_id').post(bossController.insertInGameData);

module.exports = router;