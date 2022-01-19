var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/edit', function(req, res, next) {
  res.render('user/edit', { title: 'Express' });
});
module.exports = router;
