const express = require('express');
const router = express.Router();

const categoriesController = require('./categoriesController');

// GET FORM
router.get('/setting',categoriesController.list);

router.get('/setting/detail', categoriesController.categoryDetail);

router.get('/setting/add', categoriesController.categoryAdd);

// POST FORM
router.post('/setting/detail/delete', categoriesController.deleteCategory);

router.post('/setting/detail/update',categoriesController.updateCategory);

router.post('/setting/detail/add', categoriesController.addCategory);


module.exports = router;
