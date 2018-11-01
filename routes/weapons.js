const express = require('express');
const router = express.Router();
const settings = require('../utils/settings');
const upload = require('../utils/upload');

const weaponController = require('../controllers/weaponController');

//Get weapon by ID
router.route('/:id').get(weaponController.getWeaponByID);

//Insert weapon
router.route('/')
    .post(upload([settings.UPLOAD.MEDIA, settings.UPLOAD.WEAPON]), weaponController.insertWeapon);

//Insert weapon by boss
router.route('/:boss_id')
    .post(upload([settings.UPLOAD.MEDIA, settings.UPLOAD.WEAPON]), weaponController.insertWeapon);

//Assign weapon to player(s)
router.route('/:weapon_id/players/:player_ids').post(weaponController.assignWeaponPlayer);

//Insert damage values
router.route('/:weapon_id/boss/:boss_id/game/:game_id').post(weaponController.insertDamageValues);

module.exports = router;