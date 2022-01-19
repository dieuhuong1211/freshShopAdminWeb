var express = require('express');
var router = express.Router();
const chartController = require('./chartsController');


router.get('/setting', chartController.chartReport);

router.post('/setting', chartController.timeReport);


module.exports = router;
