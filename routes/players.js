const express = require('express');
const router = express.Router();

const playerController = require('../controllers/playerController');

//Insert players by games
router.route('/:game_ids').post(playerController.insertPlayerByGames);

module.exports = router;