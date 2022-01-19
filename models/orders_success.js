const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('orders_success', {
    ORDER_ID: {
      type: DataTypes.CHAR(100),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'orders',
        key: 'ORDER_ID'
      }
    },
    CLIENT_ID: {
      type: DataTypes.CHAR(100),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'clients',
        key: 'CLIENT_ID'
      }
    },
    ISDELETED: {
      type: DataTypes.BOOLEAN,
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'orders_success',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "ORDER_ID" },
          { name: "CLIENT_ID" },
        ]
      },
      {
        name: "fk_os_cl",
        using: "BTREE",
        fields: [
          { name: "CLIENT_ID" },
        ]
      },
    ]
  });
};
