const accountService = require('./accountsService');

// GET FORM

const itemPerPage = 10;
const maximumPagination = 5;
const border = Math.floor(maximumPagination/2);
let totalPage = 1;

exports.list = async (req,res,next)=> {
    let pageArray = [];
    
    // SETUP
    try {
        const total = await accountService.allList();
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
    const accounts = await accountService.list(currentPage - 1,itemPerPage);
    res.render('accounts/setting', ({ accounts,currentPage, pageArray}));
}

exports.accountDetail = async (req,res)=> {
    const account = await accountService.accountDetail(req.query.account_id);
    var isLockable = true;
    if (res.locals.user.account_id==req.query.account_id){
        isLockable = false;
    }
    res.render('accounts/details',  {account, isLockable} );
}

exports.accountAdd = async (req,res)=> {
    res.render('accounts/add');
}


// POST FORM 
exports.addAccount = async (req,res)=> {
    await accountService.addAccount(
        req.file.filename,
        req.body.username,
        req.body.firstname,
        req.body.lastname,
        req.body.email,
        req.body.gender,
        req.body.dateofbirth,
        req.body.password)
    res.redirect('/account/setting');  
}

exports.deleteAccount = async (req,res)=> {
    await accountService.deleteAccount(req.body.account_id);
    res.redirect('/account/setting');
}

exports.updateAccount = async (req,res)=> {
    if (req.file){
        await accountService.updateAccount(req.body.account_id,
            req.file.filename,
            req.body.username,
            req.body.firstname,
            req.body.lastname,
            req.body.email,
            req.body.gender,
            req.body.dateofbirth,
            req.body.password)
        res.redirect('/account/setting');
    }else{
        await accountService.updateAccountWithoutImage(req.body.account_id,
            req.body.username,
            req.body.firstname,
            req.body.lastname,
            req.body.email,
            req.body.gender,
            req.body.dateofbirth,
            req.body.password)
        res.redirect('/account/setting');
    }
   
}

exports.lockAccount = async (req,res)=> {
     await accountService.lockAccount(req.body.account_id);
        res.redirect('/account/setting');
}

exports.unlockAccount = async (req,res)=> {
    await accountService.unlockAccount(req.body.account_id);
       res.redirect('/account/setting');
}


