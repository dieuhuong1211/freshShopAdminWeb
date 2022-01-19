var passport = require('passport')
  , LocalStrategy = require('passport-local').Strategy;
  
const { raw } = require('express');
const { options } = require('..');
const {models} = require('../../models/index');
const { Op } = require("sequelize");
const accountService = require('../accounts/accountsService');


passport.use(new LocalStrategy(
  async function(username, password, done) {
   const account = await accountService.findAccount(username);
    if (!account){
    return done(null, false, { message: 'Incorrect username.' });
    } 
    else if (account.PASS === password){
      return done(null, account);
    }
    else{
      return done(null, false, { message: 'Incorrect password.' });
    }
  }
));

function validPassword(user, password){
    return user.PASS == password;
}

passport.serializeUser(function(user, done) {
  done(null, {account_id: user.ADMIN_ID, name: user.FIRSTNAME + " " + user.LASTNAME, username:  "@" + user.USERNAME, useravatar: user.IMAGE});
});

passport.deserializeUser(function(user, done) {
  done(null, user);
});

module.exports = passport;

