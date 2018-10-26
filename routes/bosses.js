const express = require('express');
const router = express.Router();

const bossController = require('../controllers/bossController');

//Boss by id
router.route('/:id').get(bossController.getBossByID);

//Insert boss
router.route('/').post(bossController.insertBoss);

//Insert boss in-game data
router.route('/:boss_id/game/:game_id').post(bossController.insertInGameData);

module.exports = router;