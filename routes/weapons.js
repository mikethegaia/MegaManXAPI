const express = require('express');
const router = express.Router();

const weaponController = require('../controllers/weaponController');

//Insert weapon
router.route('/').post(weaponController.insertWeapon);

//Insert weapon by boss
router.route('/:boss_id').post(weaponController.insertWeapon);

//Assign weapon to player(s)
router.route('/:weapon_id/players/:player_ids').post(weaponController.assignWeaponPlayer);

//Insert damage values
router.route('/:weapon_id/boss/:boss_id/game/:game_id').post(weaponController.insertDamageValues);

module.exports = router;