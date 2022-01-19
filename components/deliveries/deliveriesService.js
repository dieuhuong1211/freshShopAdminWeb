const { raw } = require('express');
const { options } = require('..');
const {models} = require('../../models/index');
const { Op } = require("sequelize");


exports.deleteDelivery=(order_id ="0") =>{
    models.deliveries.update({ 
        ISDELETED: true
     }, {
        where: {
            ORDER_ID: order_id
        }
      });
}