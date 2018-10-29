const express = require('express');
const router = express.Router();

const collectibleController = require('../controllers/collectibleController');

//Insert collectible by stage
router.route('/:stage_id').post(collectibleController.insertCollectibleByStage);

module.exports = router;