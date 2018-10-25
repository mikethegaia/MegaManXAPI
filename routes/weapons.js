const express = require('express');
const router = express.Router();

const weaponController = require('../controllers/weaponController');

//Insert weapon
router.post('/', weaponController.insertWeapon);

//Insert weapon by boss
router.post('/:boss_id', weaponController.insertWeapon);

module.exports = router;