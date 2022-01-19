const loginService = require('./loginService');
const accountService = require('../accounts/accountsService');

exports.login = async (req,res)=> {
    res.render('login/login');
}