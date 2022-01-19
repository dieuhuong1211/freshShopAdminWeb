var express = require('express');
var router = express.Router();
const clientController = require('./clientsController');
const multer  = require('multer');
const path = require('path');
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, './public/assets/images/clients/')
    },
    filename: function (req, file, cb) {
      cb(null, Date.now() + path.extname(file.originalname)) 
    }
  })
const upload = multer({ storage: storage });


// GET FORM 
router.get('/detail', clientController.clientDetail);

router.get('/setting', clientController.list);

router.get('/setting/add', clientController.clientAdd);

router.get('/setting/detail', clientController.clientDetail);


// POST FORM 
router.post('/setting/detail/delete', clientController.deleteClient);

router.post('/setting/detail/update', upload.single('uploaded_newfile'),clientController.updateClient);

router.post('/setting/detail/add', upload.single('uploaded_file'), clientController.addClient);

router.post('/setting/detail/lock',clientController.lockClient);

router.post('/setting/detail/unlock',clientController.unlockClient);

module.exports = router;
