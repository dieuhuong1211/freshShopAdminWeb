var DataTypes = require("sequelize").DataTypes;
var _admins = require("./admins");
var _bills = require("./bills");
var _carts = require("./carts");
var _categories = require("./categories");
var _clients = require("./clients");
var _deliveries = require("./deliveries");
var _orders = require("./orders");
var _orders_detail = require("./orders_detail");
var _products = require("./products");
var _reviews = require("./reviews");
var _wishlists = require("./wishlists");

function initModels(sequelize) {
  var admins = _admins(sequelize, DataTypes);
  var bills = _bills(sequelize, DataTypes);
  var carts = _carts(sequelize, DataTypes);
  var categories = _categories(sequelize, DataTypes);
  var clients = _clients(sequelize, DataTypes);
  var deliveries = _deliveries(sequelize, DataTypes);
  var orders = _orders(sequelize, DataTypes);
  var orders_detail = _orders_detail(sequelize, DataTypes);
  var products = _products(sequelize, DataTypes);
  var reviews = _reviews(sequelize, DataTypes);
  var wishlists = _wishlists(sequelize, DataTypes);

  clients.belongsToMany(products, { as: 'PRODUCT_ID_PRODUC_TS', through: carts, foreignKey: "CLIENT_ID", otherKey: "PRODUCT_ID" });
  clients.belongsToMany(products, { as: 'PRODUCT_ID_PRODUCTS_REVIE_WS', through: reviews, foreignKey: "CLIENT_ID", otherKey: "PRODUCT_ID" });
  clients.belongsToMany(products, { as: 'PRODUCT_ID_PRODUCTS_WISHLIS_TS', through: wishlists, foreignKey: "CLIENT_ID", otherKey: "PRODUCT_ID" });
  orders.belongsToMany(products, { as: 'PRODUCT_ID_PRODUCTS_ORDERS_DETAI_LS', through: orders_detail, foreignKey: "ORDER_ID", otherKey: "PRODUCT_ID" });
  products.belongsToMany(clients, { as: 'CLIENT_ID_CLIEN_TS', through: carts, foreignKey: "PRODUCT_ID", otherKey: "CLIENT_ID" });
  products.belongsToMany(clients, { as: 'CLIENT_ID_CLIENTS_REVIE_WS', through: reviews, foreignKey: "PRODUCT_ID", otherKey: "CLIENT_ID" });
  products.belongsToMany(clients, { as: 'CLIENT_ID_CLIENTS_WISHLIS_TS', through: wishlists, foreignKey: "PRODUCT_ID", otherKey: "CLIENT_ID" });
  products.belongsToMany(orders, { as: 'ORDER_ID_ORDE_RS', through: orders_detail, foreignKey: "PRODUCT_ID", otherKey: "ORDER_ID" });
  deliveries.belongsTo(admins, { as: "MANAGER_ADMIN", foreignKey: "MANAGER"});
  admins.hasMany(deliveries, { as: "DELIVE_RIES", foreignKey: "MANAGER"});
  orders.belongsTo(admins, { as: "MANAGER_ADMIN", foreignKey: "MANAGER"});
  admins.hasMany(orders, { as: "ORDE_RS", foreignKey: "MANAGER"});
  products.belongsTo(admins, { as: "IMPORTER_ADMIN", foreignKey: "IMPORTER"});
  admins.hasMany(products, { as: "PRODUC_TS", foreignKey: "IMPORTER"});
  products.belongsTo(categories, { as: "CATEGORY_CATEGORY", foreignKey: "CATEGORY"});
  categories.hasMany(products, { as: "PRODUC_TS", foreignKey: "CATEGORY"});
  carts.belongsTo(clients, { as: "CLIENT", foreignKey: "CLIENT_ID"});
  clients.hasMany(carts, { as: "CAR_TS", foreignKey: "CLIENT_ID"});
  deliveries.belongsTo(clients, { as: "CLIENT", foreignKey: "CLIENT_ID"});
  clients.hasMany(deliveries, { as: "DELIVE_RIES", foreignKey: "CLIENT_ID"});
  orders.belongsTo(clients, { as: "CLIENT", foreignKey: "CLIENT_ID"});
  clients.hasMany(orders, { as: "ORDE_RS", foreignKey: "CLIENT_ID"});
  reviews.belongsTo(clients, { as: "CLIENT", foreignKey: "CLIENT_ID"});
  clients.hasMany(reviews, { as: "REVIE_WS", foreignKey: "CLIENT_ID"});
  wishlists.belongsTo(clients, { as: "CLIENT", foreignKey: "CLIENT_ID"});
  clients.hasMany(wishlists, { as: "WISHLIS_TS", foreignKey: "CLIENT_ID"});
  bills.belongsTo(orders, { as: "ORDER", foreignKey: "ORDER_ID"});
  orders.hasOne(bills, { as: "BILL", foreignKey: "ORDER_ID"});
  deliveries.belongsTo(orders, { as: "ORDER", foreignKey: "ORDER_ID"});
  orders.hasMany(deliveries, { as: "DELIVE_RIES", foreignKey: "ORDER_ID"});
  orders_detail.belongsTo(orders, { as: "ORDER", foreignKey: "ORDER_ID"});
  orders.hasMany(orders_detail, { as: "ORDERS_DETAI_LS", foreignKey: "ORDER_ID"});
  carts.belongsTo(products, { as: "PRODUCT", foreignKey: "PRODUCT_ID"});
  products.hasMany(carts, { as: "CAR_TS", foreignKey: "PRODUCT_ID"});
  orders_detail.belongsTo(products, { as: "PRODUCT", foreignKey: "PRODUCT_ID"});
  products.hasMany(orders_detail, { as: "ORDERS_DETAI_LS", foreignKey: "PRODUCT_ID"});
  reviews.belongsTo(products, { as: "PRODUCT", foreignKey: "PRODUCT_ID"});
  products.hasMany(reviews, { as: "REVIE_WS", foreignKey: "PRODUCT_ID"});
  wishlists.belongsTo(products, { as: "PRODUCT", foreignKey: "PRODUCT_ID"});
  products.hasMany(wishlists, { as: "WISHLIS_TS", foreignKey: "PRODUCT_ID"});

  return {
    admins,
    bills,
    carts,
    categories,
    clients,
    deliveries,
    orders,
    orders_detail,
    products,
    reviews,
    wishlists,
  };
}
module.exports = initModels;
module.exports.initModels = initModels;
module.exports.default = initModels;
