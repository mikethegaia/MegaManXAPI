const express = require('express');
const router = express.Router();

const weaponController = require('../controllers/weaponController');

//Insert weapon
router.route('/').post(weaponController.insertWeapon);

//Insert weapon by boss
router.route('/:boss_id').post(weaponController.insertWeapon);

module.exports = router;