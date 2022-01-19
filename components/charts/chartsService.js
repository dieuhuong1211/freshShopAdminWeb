const orderService = require('../orders/ordersService');
const orderDetailService = require('../order_details/orderDetailsService');
const today = new Date();

exports.revenue=async (from ,to) =>{
    
    const todate= (new Date(to)).getTime()< today.getTime()?to:today;
    const fromdate = (new Date(from)).getTime() < (new Date(todate)).getTime()? from:todate;
    const orders = await orderService.orderTime((new Date(fromdate)).getTime(), (new Date(todate)).getTime());
    var revenue = 0;
    
     for (const order of orders) {
        revenue += await orderDetailService.totalBill(order.ORDER_ID);
     }
    
    return revenue;
};


exports.totalProducts=async (from ,to) =>{
    const todate= (new Date(to)).getTime()< today.getTime()?to:today;
    const fromdate = (new Date(from)).getTime() < (new Date(todate)).getTime()? from:todate;
    const orders = await orderService.orderTime((new Date(fromdate)).getTime(), (new Date(todate)).getTime());
    var totalProduct = 0;
    
     for (const order of orders) {
        totalProduct += await orderDetailService.totalProducts(order.ORDER_ID);
     }
    
    return totalProduct;
};

exports.totalOrders=async (from ,to) =>{
    const todate= (new Date(to)).getTime()< today.getTime()?to:today;
    const fromdate = (new Date(from)).getTime() < (new Date(todate)).getTime()? from:todate;
    const orders = await orderService.orderTime((new Date(fromdate)).getTime(), (new Date(todate)).getTime());
    
    return orders.length;
};


exports.bestsellerProducts=async (from ,to) =>{
    var todate= (new Date(to)).getTime()< today.getTime()?to:today;
    var fromdate = (new Date(from)).getTime() < (new Date(todate)).getTime()? from:todate;

    var orderDetails = await orderDetailService.listFillterTime((new Date(fromdate)).getTime(), (new Date(todate)).getTime());

   if (orderDetails.length > 0){
     for (let i = orderDetails.length-1; i>=0; i--){
        for (let j = i - 1; j>=0; j--){
            if ((i<orderDetails.length) && (orderDetails[i].PRODUCT_ID === orderDetails[j].PRODUCT_ID)){
                orderDetails[i].QUANTITY += orderDetails[j].QUANTITY;
                    i--;
                orderDetails.splice(j, 1);
            }
        }
     }
    
     for (let i = orderDetails.length-1; i>=0; i--){
        for (let j = i - 1; j>=0; j--){
            if ((orderDetails[i].QUANTITY >= orderDetails[j].QUANTITY)){
              const temp = orderDetails[i];
              orderDetails[i] = orderDetails[j];
              orderDetails[j] = temp;
            }
        }
     }
    }

    return orderDetails;
};

