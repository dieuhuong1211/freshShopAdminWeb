const clientService = require('./clientsService');

// GET FORM


const itemPerPage = 10;
const maximumPagination = 5;
const border = Math.floor(maximumPagination/2);
let totalPage = 1;

exports.list = async (req,res,next)=> {
    let pageArray = [];
    
    // SETUP
    try {
        const total = await clientService.allList();
        let totalitem=total.length;
        totalPage = Math.ceil(totalitem/itemPerPage) ;

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
    const clients = await clientService.list(currentPage - 1,itemPerPage);
    res.render('clients/setting', ({ clients,currentPage, pageArray}));
}

exports.clientDetail = async (req,res)=> {
    const client = await clientService.clientDetail(req.query.client_id);
    var isLockable = true;
    res.render('clients/details',  {client, isLockable} );
}

exports.clientAdd = async (req,res)=> {
    res.render('clients/add');
}


// POST FORM 
exports.addClient = async (req,res)=> {
    await clientService.addClient(
        req.file.filename,
        req.body.firstname,
        req.body.lastname,
        req.body.gender,
        req.body.dateofbirth,
        req.body.phone,
        req.body.email,
        req.body.password)
    res.redirect('/client/setting');  
}

exports.deleteClient = async (req,res)=> {
    await clientService.deleteClient(req.body.client_id);
    res.redirect('/client/setting');
}

exports.updateClient = async (req,res)=> {
    if (req.file){
        await clientService.updateClient(req.body.client_id,
            req.file.filename,
            req.body.firstname,
            req.body.lastname,
            req.body.gender,
            req.body.dateofbirth,
            req.body.phone,
            req.body.email,
            req.body.password)
        res.redirect('/client/setting');
    }else{
        await clientService.updateClientWithoutImage(req.body.client_id,
            req.body.firstname,
            req.body.lastname,
            req.body.gender,
            req.body.dateofbirth,
            req.body.phone,
            req.body.email,
            req.body.password)
        res.redirect('/client/setting');
    }
   
}

exports.lockClient = async (req,res)=> {
     await clientService.lockClient(req.body.client_id);
        res.redirect('/client/setting');
}

exports.unlockClient = async (req,res)=> {
    await clientService.unlockCLient(req.body.client_id);
       res.redirect('/client/setting');
}


