const express = require('express');
const router = express.Router();

const bossController = require('../controllers/bossController');

//Boss by id
router.get('/:id', bossController.getBossByID);

//Insert boss
router.post('/', bossController.insertBoss);

module.exports = router;