const express = require('express');
const router = express.Router();

const bossController = require('../controllers/bossController');

//Boss by id
router.get('/:id', bossController.getBossByID);

//Insert boss
router.post('/', bossController.insertBoss);

//Insert boss in-game data
router.post('/:boss_id/game/:game_id', bossController.insertInGameData);

module.exports = router;