const express = require('express');
const router = express.Router();

//Routes
const bosses = require('./bosses');
const games = require('./games');

/* GET home page. */
router.get('/', function (req, res, next) {
	res.render('index', { title: 'Express' });
});

router.use('/bosses', bosses);
router.use('/games', games);

module.exports = router;