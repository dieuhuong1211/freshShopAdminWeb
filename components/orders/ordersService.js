const { raw } = require('express');
const { options } = require('..');
const {models} = require('../../models/index');
const { v1: uuidv1 } = require('uuid');
const { Op } = require("sequelize");

//, {model: models.orders_return ,as: "orders_returns"}

exports.list=(page = 0, itemPerPage ) =>{
    return models.orders.findAll({
        include: [{model: models.clients , as: "CLIENT",attributes: ['LASTNAME']},{model: models.deliveries , as: "DELIVE_RIES",attributes: ['DELIVERY_STATUS']}],
        where: {
            ISDELETED: false
          },
        offset:page*itemPerPage,
        limit: itemPerPage,
        raw:true,
        nest : true
    });
};

exports.alllist=() =>{
    return models.orders.findAll({
        include: [{model: models.clients , as: "CLIENT",attributes: ['LASTNAME']},{model: models.deliveries , as: "DELIVE_RIES",attributes: ['DELIVERY_STATUS']}],
        where: {
            ISDELETED: false
          },
        raw:true,
        nest : true
    });
};

exports.orderDetail=(order_id ="0") =>{
    return models.orders.findOne({
        include: [{model: models.bills , as: "BILL"}, {model: models.clients , as: "CLIENT",attributes: ['LASTNAME']}, {model: models.admins , as: "MANAGER_ADMIN",attributes: ['LASTNAME']}, {model: models.deliveries , as: "DELIVE_RIES",attributes: ['DELIVERY_STATUS']}   ],
        where: {
        ORDER_ID: order_id,
        ISDELETED: false
          },
        raw:true,
        nest : true
    });
}


exports.deleteOrder=(order_id ="0") =>{
    models.orders.update({ 
        ISDELETED: true
     }, {
        where: {
            ORDER_ID: order_id
        }
      });
}

exports.orderTime=(from, to) =>{
    return models.orders.findAll({
        where: {    
            [Op.and]: [{ORDER_DATE: {[Op.gte]: from}}, {ORDER_DATE: {[Op.lte]: to}} ],
            ISDELETED: false
          },
        raw:true,
        nest : true
    });
};



