const { raw } = require('express');
const { options } = require('../../models');
const {models} = require('../../models/index');
const { v1: uuidv1 } = require('uuid');
const { Op } = require("sequelize");

// GET FORM
exports.allList=() =>{
    return models.clients.findAll({
        where: {
            ISDELETED: false
          },
        raw:true
    });
};


exports.list=(page = 0,itemPerPage) =>{
    return models.clients.findAll({
        where: {
            ISDELETED: false
          },
        offset:page*itemPerPage,
        limit: itemPerPage,
        raw:true
    });
};

exports.clientDetail=(client_id ="0") =>{
    return models.clients.findOne({
        where: {
            CLIENT_ID: client_id
          },
        raw:true
    });
}

// POST FORM
exports.addClient=(filename,firstname,lastname,gender,dateofbirth,phone,email,password) =>{
    
    const newclient =  models.clients.create({ 
        CLIENT_ID: uuidv1(),
        IMAGE: "/assets/images/clients/" + filename,
        FIRSTNAME: firstname,
        LASTNAME: lastname,
        GENDER: gender,
        DOB: dateofbirth,
        PHONE: phone,
        EMAIL: email,
        PASS: password,
        ISDELETED: false,
        ISLOCK: false
      });
}

exports.deleteClient=(client_id ="0") =>{
    models.clients.update({ 
        ISDELETED: true
     }, {
        where: {
            CLIENT_ID: client_id
        }
      });
}

exports.updateClient=(client_id ="0", filename,firstname,lastname,gender,dateofbirth,phone,email,password) =>{
    models.clients.update({ 
        IMAGE: "/assets/images/clients/" + filename,
        FIRSTNAME: firstname,
        LASTNAME: lastname,
        GENDER: gender,
        DOB: dateofbirth,
        PHONE: phone,
        EMAIL: email,
        PASS: password
     }, {
        where: {
            CLIENT_ID: client_id
        }
      });
}

exports.lockClient=(client_id ="0") =>{
    models.clients.update({ 
        ISLOCK: true
     }, {
        where: {
            CLIENT_ID: client_id
        }
      });
}

exports.unlockClient=(client_id ="0") =>{
    models.clients.update({ 
        ISLOCK: false
     }, {
        where: {
            CLIENT_ID: client_id
        }
      });
}

exports.updateClientWithoutImage=(client_id ="0",firstname,lastname,gender,dateofbirth,phone,email,password) =>{
    models.clients.update({ 
        FIRSTNAME: firstname,
        LASTNAME: lastname,
        GENDER: gender,
        DOB: dateofbirth,
        PHONE: phone,
        EMAIL: email,
        PASS: password
     }, {
        where: {
            CLIENT_ID: client_id
        }
      });
}
