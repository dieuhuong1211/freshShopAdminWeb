const { raw } = require('express');
const { options } = require('..');
const {models} = require('../../models/index');

const { Op } = require("sequelize");


exports.findAccount=(username ="0") =>{
    return models.admins.findOne({
        where: {
            USERNAME: username,
            ISDELETED: false,
            ISLOCK: false
          },
        raw:true
    });
}