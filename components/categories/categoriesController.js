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
        const total = await categoryService.allList();
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
    const categories = await categoryService.list(currentPage-1,itemPerPage);
    res.render('categories/setting', ({ categories,currentPage, pageArray}));
}



exports.categoryDetail = async (req,res)=> {
    const category = await categoryService.categoryDetail(req.query.category_id);
    res.render('categories/details',  {category} );
}


exports.categoryAdd = async (req,res)=> {
    res.render('categories/add');
}


// POST FORM
exports.deleteCategory = async (req,res)=> {
    await categoryService.deleteCategory(req.body.category_id);
    res.redirect('/category/setting');
}

exports.updateCategory = async (req,res)=> {
        await categoryService.updateCategory(req.body.category_id,
            req.body.category_name);
        res.redirect('/category/setting');

}

exports.addCategory = async (req,res)=> {
    await categoryService.addCategory(req.body.category_name);
    res.redirect('/category/setting');
}
