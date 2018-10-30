const express = require('express');
const router = express.Router();

const stageController = require('../controllers/stageController');

//Stage by id
router.route('/:id').get(stageController.getStageByID);

//Insert stage
router.route('/').post(stageController.insertStage);

module.exports = router;