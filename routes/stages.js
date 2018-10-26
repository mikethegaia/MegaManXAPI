const express = require('express');
const router = express.Router();

const stageController = require('../controllers/stageController');

//Stage by id
//router.get('/:id', gameController.getGameByID)

//Insert stage
router.route('/').post(stageController.insertStage);

module.exports = router;