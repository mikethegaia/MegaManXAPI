const express = require('express');
const router = express.Router();
const settings = require('../utils/settings');
const upload = require('../utils/upload');

const playerController = require('../controllers/playerController');

//Get player by id
router.route('/:id').get(playerController.getPlayerByID);

//Insert players by games
router.route('/:game_ids')
    .post(upload([settings.UPLOAD.MEDIA, settings.UPLOAD.PLAYER]), playerController.insertPlayerByGames);

module.exports = router;