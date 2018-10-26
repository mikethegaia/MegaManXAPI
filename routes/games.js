const express = require('express');
const router = express.Router();

const gameController = require('../controllers/gameController');

//Game by id
router.route('/:id').get(gameController.getGameByID)

//Insert game
router.route('/').post(gameController.insertGame);

module.exports = router;