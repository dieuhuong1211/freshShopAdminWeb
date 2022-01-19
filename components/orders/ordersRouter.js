const express = require('express');
const router = express.Router();
const ordersController = require('./ordersController');


router.get('/setting',ordersController.list);

router.get('/setting/detail', ordersController.orderDetail);

router.post('/setting/detail/delete', ordersController.deleteOrder);

module.exports = router;
