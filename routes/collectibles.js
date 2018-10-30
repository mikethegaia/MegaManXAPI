const express = require('express');
const router = express.Router();

const collectibleController = require('../controllers/collectibleController');

//Get collectible by ID
router.route('/:id').get(collectibleController.getCollectibleByID);

//Get armor by ID
router.route('/armor/:id').get(collectibleController.getArmorByID);

//Insert collectible by stage and game
router.route('/stage/:stage_id/game/:game_id').post(collectibleController.insertCollectibleByStageGame);

//Insert armor
router.route('/armor').post(collectibleController.insertArmor);

module.exports = router;