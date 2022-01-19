var express = require('express');
var router = express.Router();
const passport = require('./passport');
const loginController = require('./loginController');

router.get('/',loginController.login);

router.post('/',
  passport.authenticate('local', { 
      successRedirect: '/',
      failureRedirect: '/login',
       failureFlash: true 
    }) 
);

router.get('/logout', function(req, res){
  req.logout();
  delete req.user;
  res.redirect('/');
});

module.exports = router;
