const express = require('express');
const router = express.Router();
const settings = require('../utils/settings');
const upload = require('../utils/upload');

const stageController = require('../controllers/stageController');

//Stage by id
router.route('/:id').get(stageController.getStageByID);

//Insert stage
router.route('/')
    .post(upload([settings.UPLOAD.MEDIA, settings.UPLOAD.STAGE]), stageController.insertStage);

module.exports = router;