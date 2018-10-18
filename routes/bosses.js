const express = require('express');
const router = express.Router();

const bossController = require('../controllers/bossController');

//Boss by id
router.get('/:id', bossController.getBossByID);

module.exports = router;