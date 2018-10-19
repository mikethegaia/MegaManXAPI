const express = require('express');
const router = express.Router();

const gameController = require('../controllers/gameController');

//Game by id
router.get('/:id', gameController.getGameByID)

//Insert game
router.post('/', gameController.insertGame);

module.exports = router;