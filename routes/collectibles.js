const express = require('express');
const router = express.Router();

const collectibleController = require('../controllers/collectibleController');

//Insert collectible by stage and game
router.route('/stage/:stage_id/game/:game_id').post(collectibleController.insertCollectibleByStageGame);

//Insert armor
router.route('/armor').post(collectibleController.insertArmor);

module.exports = router;