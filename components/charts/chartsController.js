const chartService = require('./chartsService');

const orders = require('../../models/orders');

exports.timeReport = async (req,res)=> {
    const revenue = await chartService.revenue(req.body.from, req.body.to);
    const totalProduct = await chartService.totalProducts(req.body.from, req.body.to);
    const totalOrder = await chartService.totalOrders(req.body.from, req.body.to);
    const bestseller = await chartService.bestsellerProducts(req.body.from, req.body.to);
    const report = {
        REVENUE: revenue,
        TOTALPRODUCT: totalProduct,
        TOTALORDER: totalOrder,
        FROM: req.body.from,
        TO: req.body.to,
        BESTSELLERPRODUCTS: bestseller
      };
    res.render('charts/setting',  {report});
}


exports.chartReport = async (req,res)=> {
 

    var to = new Date();
    var from = new Date();
    from.setMonth(from.getMonth() - 1);

    const revenue = await chartService.revenue(from, to);
    const totalProduct = await chartService.totalProducts(from, to);
    const totalOrder = await chartService.totalOrders(from, to);
    const report = {
        REVENUE: revenue,
        TOTALPRODUCT: totalProduct,
        TOTALORDER: totalOrder, 
        FROM: from,
        TO: to
      };
    res.render('charts/setting',  {report});
}