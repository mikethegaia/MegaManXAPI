const express = require('express');
const router = express.Router();

const weaponController = require('../controllers/weaponController');

//Insert weapon
router.route('/').post(weaponController.insertWeapon);

//Insert weapon by boss
router.route('/:boss_id').post(weaponController.insertWeapon);

//Insert damage values
router.route('/:weapon_id/boss/:boss_id/game/:game_id').post(weaponController.insertDamageValues);

module.exports = router;