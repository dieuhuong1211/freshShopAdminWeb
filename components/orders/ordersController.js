const orderService = require('./ordersService');
const orderDetailService = require('../order_details/orderDetailsService');
const accountService = require('../accounts/accountsService');
const deliveryService = require('../deliveries/deliveriesService');
const billService = require ('../bill/billsService');


const itemPerPage = 10;
const maximumPagination = 5;
const border = Math.floor(maximumPagination/2);
let totalPage = 1;

exports.list = async (req,res,next)=> {
    let pageArray = [];
    
    // SETUP
    try {
        const total = await orderService.alllist();
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
    const orders = await orderService.list(currentPage - 1,itemPerPage);
    res.render('orders/setting', ({ orders,currentPage, pageArray}));
}


exports.orderDetail = async (req,res)=> {
    const order = await orderService.orderDetail(req.query.order_id);
    const orderDetails = await orderDetailService.listFillter(req.query.order_id);
    const totalBill =  await orderDetailService.totalBill(req.query.order_id);
    const accounts = await accountService.allList();
    const bill = await billService.billDetail(req.query.order_id);
   const payment = totalBill + bill.TAX + bill.SHIPPING_COST - bill.DISCOUNT;
    res.render('orders/details',  {order, orderDetails, accounts, totalBill, payment} );
}

exports.deleteOrder = async (req,res)=> {
    await orderDetailService.deleteOrderDetail(req.body.order_id);
    await deliveryService.deleteDelivery(req.body.order_id);
    await orderService.deleteOrder(req.body.order_id);
    res.redirect('/order/setting');
}
