const express = require('express');
const router = express.Router();

const playerController = require('../controllers/playerController');

//Get player by id
router.route('/:id').get(playerController.getPlayerByID);

//Insert players by games
router.route('/:game_ids').post(playerController.insertPlayerByGames);

module.exports = router;