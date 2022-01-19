const express = require('express');
const router = express.Router();
const multer  = require('multer');
const path = require('path');
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, './public/assets/images/products/')
    },
    filename: function (req, file, cb) {
      cb(null, Date.now() + path.extname(file.originalname)) 
    }
  })
const upload = multer({ storage: storage });
const productsController = require('./productsController');

// GET FORM
router.get('/setting',productsController.list);

router.get('/setting/detail', productsController.productDetail);

router.get('/setting/add', productsController.productAdd);

// POST FORM
router.post('/setting/detail/delete', productsController.deleteProduct);

router.post('/setting/detail/update', upload.single('uploaded_newfile'),productsController.updateProduct);

router.post('/setting/detail/add', upload.single('uploaded_file'), productsController.addProduct);

router.post('/setting/filter',productsController.fillterProduct);

module.exports = router;
