var express = require('express');
var router = express.Router();
const accountController = require('./accountsController');
const multer  = require('multer');
const path = require('path');
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, './public/assets/images/accounts/')
    },
    filename: function (req, file, cb) {
      cb(null, Date.now() + path.extname(file.originalname)) 
    }
  })
const upload = multer({ storage: storage });


// GET FORM 
router.get('/detail', accountController.accountDetail);

router.get('/setting', accountController.list);

router.get('/setting/add', accountController.accountAdd);

router.get('/setting/detail', accountController.accountDetail);


// POST FORM 
router.post('/setting/detail/delete', accountController.deleteAccount);

router.post('/setting/detail/update', upload.single('uploaded_newfile'),accountController.updateAccount);

router.post('/setting/detail/add', upload.single('uploaded_file'), accountController.addAccount);

router.post('/setting/detail/lock',accountController.lockAccount);

router.post('/setting/detail/unlock',accountController.unlockAccount);

module.exports = router;
