var express = require('express');
var router = express.Router();

var bossController = require('../controllers/bossController');

//All Bosses
router.get('/', bossController.getBosses);
//Boss by id
router.get('/:id', bossController.getBossByID);
//Boss by game
router.get('/game/:id', bossController.getBossByGame);
//Add a boss
router.post('/', bossController.addBoss);

module.exports = router;