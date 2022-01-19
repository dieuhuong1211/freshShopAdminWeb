const { raw } = require('express');
const { options } = require('..');
const {models} = require('../../models/index');
const { v1: uuidv1 } = require('uuid');
const { Op } = require("sequelize");

exports.allList=() =>{
    return models.categories.findAll({
        where: {
            ISDELETED: false
          },
        raw:true
    });
};

exports.list=(page, itemPerPage) =>{
    return models.categories.findAll({  
        where: {
            ISDELETED: false
          },
        offset:page*itemPerPage,
        limit: itemPerPage,
        raw:true,
        nest : true
    });
};



exports.categoryDetail=(category_id ="0") =>{
    return models.categories.findOne({
        where: {
            CATEGORY_ID: category_id
          },
        raw:true
    });
}

// POST FORM
exports.deleteCategory=(category_id ="0") =>{
    models.categories.update({ 
        ISDELETED: true
     }, {
        where: {
            CATEGORY_ID: category_id
        }
      });
}

exports.updateCategory=(category_id ="0", category_name) =>{
    models.categories.update({ 
        CATEGORY_NAME: category_name
     }, {
        where: {
            CATEGORY_ID: category_id
        }
      });
}

exports.addCategory=(category_name) =>{
    
    const newcategory =  models.categories.create({ 
        CATEGORY_ID: uuidv1(),
        CATEGORY_NAME: category_name,
        ISDELETED: false
      });
}
