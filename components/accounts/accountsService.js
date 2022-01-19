const { raw } = require('express');
const { options } = require('..');
const {models} = require('../../models/index');
const { v1: uuidv1 } = require('uuid');
const { Op } = require("sequelize");

// GET FORM
exports.allList=() =>{
    return models.admins.findAll({
        where: {
            ISDELETED: false
          },
        raw:true
    });
};

exports.findAccount=(username ="0") =>{
    return models.admins.findOne({
        where: {
            USERNAME: username,
            ISDELETED: false
          },
        raw:true
    });
}

exports.list=(page = 0, itemPerPage = 10 ) =>{
    return models.admins.findAll({
        where: {
            ISDELETED: false
          },
        offset:page*itemPerPage,
        limit: itemPerPage,
        raw:true
    });
};

exports.accountDetail=(account_id ="0") =>{
    return models.admins.findOne({
        where: {
            ADMIN_ID: account_id
          },
        raw:true
    });
}

// POST FORM
exports.addAccount=(filename,username, firstname,lastname,email,gender,dateofbirth,password) =>{
    
    const newproduct =  models.admins.create({ 
        ADMIN_ID: uuidv1(),
        IMAGE: "/assets/images/accounts/" + filename,
        USERNAME: username,
        FIRSTNAME: firstname,
        LASTNAME: lastname,
        EMAIL: email,
        GENDER: gender,
        DOB: dateofbirth,
        PASS: password,
        ISDELETED: false,
        ISLOCK: false
      });
}

exports.deleteAccount=(account_id ="0") =>{
    models.admins.update({ 
        ISDELETED: true
     }, {
        where: {
            ADMIN_ID: account_id
        }
      });
}

exports.updateAccount=(account_id ="0", filename,username, firstname,lastname,email,gender,dateofbirth,password) =>{
    models.admins.update({ 
        IMAGE: "/assets/images/accounts/" + filename,
        USERNAME: username,
        FIRSTNAME: firstname,
        LASTNAME: lastname,
        EMAIL: email,
        GENDER: gender,
        DOB: dateofbirth,
        PASS: password
     }, {
        where: {
            ADMIN_ID: account_id
        }
      });
}

exports.lockAccount=(account_id ="0") =>{
    models.admins.update({ 
        ISLOCK: true
     }, {
        where: {
            ADMIN_ID: account_id
        }
      });
}

exports.unlockAccount=(account_id ="0") =>{
    models.admins.update({ 
        ISLOCK: false
     }, {
        where: {
            ADMIN_ID: account_id
        }
      });
}

exports.updateAccountWithoutImage=(account_id ="0",username, firstname,lastname,email,gender,dateofbirth,password) =>{
    models.admins.update({ 
        USERNAME: username,
        FIRSTNAME: firstname,
        LASTNAME: lastname,
        EMAIL: email,
        GENDER: gender,
        DOB: dateofbirth,
        PASS: password
     }, {
        where: {
            ADMIN_ID: account_id
        }
      });
}
