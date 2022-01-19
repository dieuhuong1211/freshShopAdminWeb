const { raw } = require('express');
const { options } = require('..');
const {models} = require('../../models/index');
const { v1: uuidv1 } = require('uuid');
const { Op } = require("sequelize");

exports.billDetail=(order_id ="0") =>{
    return models.bills.findOne({ 
        where: {
        ORDER_ID: order_id,
        ISDELETED: false
          },
        raw:true,
        nest : true
    });
}