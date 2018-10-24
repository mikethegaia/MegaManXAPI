const express = require('express');
const router = express.Router();

//Routes
const bosses = require('./bosses');
const stages = require('./stages');
const games = require('./games');
const players = require('./players');

/* GET home page. */
router.get('/', function (req, res, next) {
	res.render('index', { title: 'Express' });
});

router.use('/bosses', bosses);
router.use('/stages', stages);
router.use('/games', games);
router.use('/players', players);

module.exports = router;