const express = require('express');
const router = express.Router();

const playerController = require('../controllers/playerController');

//Insert players by games
router.post('/:game_ids', playerController.insertPlayerByGames);

module.exports = router;