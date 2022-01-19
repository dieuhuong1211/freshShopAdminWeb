const { raw } = require('express');
const { options } = require('..');
const {models} = require('../../models/index');
const { v1: uuidv1 } = require('uuid');
const { Op } = require("sequelize");

// GET FORM
exports.listFillter=(page = 0, itemPerPage = 10, product_name = null,category = null,sold = null,quantity = null,cost = null,importer = null,importdate = null) =>{
    return models.products.findAll({
        include: [ {model: models.categories, as: "CATEGORY_CATEGORY"}, {model: models.admins ,  attributes: ['LASTNAME'],as: "IMPORTER_ADMIN"}  ],
        where: {
            [Op.and]:[
            {PRODUCT_NAME: product_name},
            {CATEGORY: category},
            {SOLD: sold},
            {QUANTITY: quantity},
            {PRICE: cost}
            
            ],
            [Op.and]:[
            {ISDELETED: false}
            ]
          },
        offset:page*itemPerPage,
        limit: itemPerPage,
        raw:true,
        nest : true
    });
};

exports.list=(page, itemPerPage) =>{
    return models.products.findAll({
        include: [ {model: models.categories, as: "CATEGORY_CATEGORY"}, {model: models.admins ,  attributes: ['LASTNAME'],as: "IMPORTER_ADMIN"}  ],
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
    return models.products.findAll({
        include: [ {model: models.categories, as: "CATEGORY_CATEGORY"}, {model: models.admins ,  attributes: ['LASTNAME'],as: "IMPORTER_ADMIN"}  ],
        where: {
            ISDELETED: false
          },
        raw:true,
        nest : true
    });
};


exports.productDetail=(product_id ="0") =>{
    return models.products.findOne({
        where: {
            PRODUCT_ID: product_id
          },
        raw:true
    });
}

// POST FORM
exports.deleteProduct=(product_id ="0") =>{
    models.products.update({ 
        ISDELETED: true
     }, {
        where: {
            PRODUCT_ID: product_id
        }
      });
}

exports.updateProduct=(product_id ="0", product_name,filename,category,sold,quantity,description,cost,importer,importdate) =>{
    models.products.update({ 
        PRODUCT_NAME: product_name,
        IMAGE: "/assets/images/products/" + filename,
        CATEGORY: category,
        SOLD: sold,
        QUANTITY: quantity,
        DETAIL: description,
        PRICE: cost,
        IMPORTER: importer,
        IMPORTDATE: importdate
     }, {
        where: {
            PRODUCT_ID: product_id
        }
      });
}

exports.updateProductWithoutImage=(product_id ="0", product_name,category,sold,quantity,description,cost,importer,importdate) =>{
    models.products.update({ 
        PRODUCT_NAME: product_name,
        CATEGORY: category,
        SOLD: sold,
        QUANTITY: quantity,
        DETAIL: description,
        PRICE: cost,
        IMPORTER: importer,
        IMPORTDATE: importdate
     }, {
        where: {
            PRODUCT_ID: product_id
        }
      });
}

exports.addProduct=(product_name,filename,category,sold,quantity,description,cost,importer,importdate) =>{
    
    const newproduct =  models.products.create({ 
        PRODUCT_ID: uuidv1(),
        PRODUCT_NAME: product_name,
        IMAGE: "/assets/images/products/" + filename,
        CATEGORY: category,
        SOLD: sold,
        QUANTITY: quantity,
        DETAIL: description,
        PRICE: cost,
        IMPORTER: importer,
        IMPORTDATE: importdate,
        ISDELETED: false
      });
}
