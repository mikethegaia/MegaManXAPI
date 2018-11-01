const express = require('express');
const router = express.Router();
const settings = require('../utils/settings');
const upload = require('../utils/upload');

const gameController = require('../controllers/gameController');

//Game by id
router.route('/:id').get(gameController.getGameByID)

//Insert game
router.route('/').
    post(upload([settings.UPLOAD.MEDIA, settings.UPLOAD.GAME]), gameController.insertGame);

module.exports = router;