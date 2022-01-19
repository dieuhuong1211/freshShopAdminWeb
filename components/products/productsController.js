const productService = require('./productService');
const accountService = require('../accounts/accountsService');
const categoryService = require('../categories/categoriesService');

//GET FORM
const itemPerPage = 10;
const maximumPagination = 5;
const border = Math.floor(maximumPagination/2);
let totalPage = 1;

exports.list = async (req,res,next)=> {
    let pageArray = [];
    
    // SETUP
    try {
        const total = await productService.alllist();
        let totalitem=total.length;
        totalPage = Math.ceil(totalitem/itemPerPage);

    }catch (error) {
        console.log(error);
        next(error);
    }
    let currentPage = 1;
    let queryPage = String(req.query.page);

    if (queryPage.includes("previous")){
        queryPage = queryPage.slice(queryPage.indexOf("-") + 1, queryPage.length);
         currentPage = (queryPage && !Number.isNaN(queryPage)) ? parseInt(queryPage) - 1 : 1;
    }else if (queryPage.includes("next")){
        queryPage = queryPage.slice(queryPage.indexOf("-") + 1, queryPage.length);
        currentPage = (queryPage && !Number.isNaN(queryPage)) ? parseInt(queryPage) + 1 : 1;
    }
    else {
        currentPage = (queryPage && !Number.isNaN(queryPage)) ? parseInt(queryPage) : 1;
    }
    
    //CHECK DATA 
    
    currentPage = (currentPage > 0) ? currentPage : 1;
    currentPage = (currentPage <= totalPage) ? currentPage : totalPage
    
    if (totalPage <= maximumPagination){
        for(let i = 1 ; i <= totalPage; i++){
            if(currentPage === i){
                pageArray.push({
                    PAGE: i,
                    ISCURRENT:  true
                });
            }
            else{
                pageArray.push({
                    PAGE: i,
                    ISCURRENT:  false
                });
            }
        }
    }else{
        if ((border < currentPage) && (currentPage < totalPage - border + 1)){
            for(let i = currentPage - border ; i <= currentPage + border; i++){
                if(currentPage === i){
                    pageArray.push({
                        PAGE: i,
                        ISCURRENT:  true
                    });
                }
                else{
                    pageArray.push({
                        PAGE: i,
                        ISCURRENT:  false
                    });
                }
            }
        }else if (currentPage <= border) {
            for(let i = 1 ; i <= maximumPagination; i++){
                if(currentPage === i){
                    pageArray.push({
                        PAGE: i,
                        ISCURRENT:  true
                    });
                }
                else{
                    pageArray.push({
                        PAGE: i,
                        ISCURRENT:  false
                    });
                }
            }
        } else if (totalPage - border + 1 <= currentPage){
            for(let i = totalPage - maximumPagination + 1 ; i <= totalPage; i++){
                if(currentPage === i){
                    pageArray.push({
                        PAGE: i,
                        ISCURRENT:  true
                    });
                }
                else{
                    pageArray.push({
                        PAGE: i,
                        ISCURRENT:  false
                    });
                }
            }
        }
    }
    const products = await productService.list(currentPage-1,itemPerPage);
    res.render('products/setting', ({ products,currentPage, pageArray}));
}



exports.productDetail = async (req,res)=> {
    const product = await productService.productDetail(req.query.product_id);
    const accounts = await accountService.allList();
    const categories = await categoryService.allList();
    res.render('products/details',  {product, categories, accounts} );
}


exports.productAdd = async (req,res)=> {
    const accounts = await accountService.allList();
    const categories = await categoryService.allList();
    res.render('products/add', {categories, accounts});
}


// POST FORM
exports.deleteProduct = async (req,res)=> {
    await productService.deleteProduct(req.body.product_id)
    res.redirect('/product/setting');
}

exports.updateProduct = async (req,res)=> {
    if (req.file){
        await productService.updateProduct(req.body.product_id,
            req.body.product_name,
            req.file.filename,
            req.body.category,
            req.body.sold,
            req.body.quantity,
            req.body.description,
            req.body.cost,
            req.body.importer,
            req.body.importdate)
        res.redirect('/product/setting');
    }else{
        await productService.updateProductWithoutImage(req.body.product_id,
            req.body.product_name,
            req.body.category,
            req.body.sold,
            req.body.quantity,
            req.body.description,
            req.body.cost,
            req.body.importer,
            req.body.importdate)
        res.redirect('/product/setting');
    }
   
}

exports.addProduct = async (req,res)=> {
    await productService.addProduct(
                                       req.body.product_name,
                                       req.file.filename,
                                       req.body.category,
                                       req.body.sold,
                                       req.body.quantity,
                                       req.body.description,
                                       req.body.cost,
                                       req.body.importer,
                                       req.body.importdate)
    res.redirect('/product/setting');
}

exports.fillterProduct = async (req,res)=> {
    const products = await productService.listFillter(
        !isNaN(req.query.page) && req.query.page > 0? req.query.page - 1:0, 10,
                                       req.body.product_name,
                                       req.body.category,
                                       req.body.sold,
                                       req.body.quantity,
                                       req.body.cost
        )
    const accounts = await accountService.allList();
    res.render('products/setting', { products,page:req.query.page, accounts });
}