DROP DATABASE IF EXISTS freshshopdb; 
CREATE DATABASE IF NOT EXISTS freshshopdb;
USE freshshopdb;

create table products (
    PRODUCT_ID CHAR(100) NOT NULL,
    IMAGE VARCHAR(250),
    PRODUCT_NAME VARCHAR(100),
    CATEGORY CHAR(100),
    STOCK ENUM('IN STOCK', 'OUT STOCK'), 
    QUANTITY INT(10),
    SOLD INT(10),
    PRICE FLOAT(10),
    IMPORTDATE DATE,
    IMPORTER CHAR(100),
    DETAIL VARCHAR(1000),
    ISDELETED BOOL,
    PRIMARY KEY (PRODUCT_ID)
)  ENGINE=INNODB;

create table categories(
	CATEGORY_ID CHAR(100) NOT NULL, 
	CATEGORY_NAME VARCHAR(100), 
    ISDELETED BOOL,
	PRIMARY KEY (CATEGORY_ID)
)ENGINE = INNODB;

create table  clients 
(
	CLIENT_ID CHAR(100) NOT NULL, 
	FIRSTNAME VARCHAR(50), 
    LASTNAME VARCHAR(50), 
	GENDER  ENUM('Female', 'Male'), 
    DOB DATE, 
    PHONE VARCHAR(20),
    IMAGE VARCHAR(100),
    EMAIL VARCHAR(50), 
	PASS VARCHAR(1000),  
    ISDELETED BOOL,
    ISLOCK BOOL,
	PRIMARY KEY (CLIENT_ID)
)ENGINE = INNODB;

create table admins
(
	ADMIN_ID CHAR(100) NOT NULL, 
	FIRSTNAME VARCHAR(50), 
    LASTNAME VARCHAR(50), 
    GENDER  ENUM('Female', 'Male'), 
    DOB DATE, 
    EMAIL VARCHAR(50), 
    IMAGE VARCHAR(100),
    USERNAME VARCHAR(50), 
	PASS VARCHAR(50),  
    ISDELETED BOOL,
    ISLOCK BOOL,
	PRIMARY KEY (ADMIN_ID)
)ENGINE = INNODB;
    
create table carts 
(
	CLIENT_ID CHAR(100) NOT NULL, 
	PRODUCT_ID CHAR(100) NOT NULL, 
	QUANTITY INT(10),  
    ISDELETED BOOL,
	PRIMARY KEY (CLIENT_ID, PRODUCT_ID)
)ENGINE = INNODB;

create table wishlists
(
	CLIENT_ID CHAR(100) NOT NULL, 
	PRODUCT_ID CHAR(100) NOT NULL, 
    ISDELETED BOOL,
	PRIMARY KEY (CLIENT_ID, PRODUCT_ID)
)ENGINE = INNODB;

create table reviews
(
	PRODUCT_ID CHAR(100) NOT NULL, 
    CLIENT_ID CHAR(100) NOT NULL, 
    REVIEW VARCHAR(200),
    REVIEWDATE DATE,
    ISDELETED BOOL,
	PRIMARY KEY (CLIENT_ID, PRODUCT_ID)
)ENGINE = INNODB;

create table orders 
(
	ORDER_ID CHAR(100) NOT NULL, 
    ORDER_DATE TIMESTAMP,
    ADDRESS VARCHAR(100),
    MANAGER CHAR(100),
    CLIENT_ID CHAR(100),
    ISDELETED BOOL,
	PRIMARY KEY (ORDER_ID)
)ENGINE = INNODB;

create table orders_detail
(
	ORDER_ID CHAR(100) NOT NULL, 
	PRODUCT_ID CHAR(100) NOT NULL, 
    QUANTITY INT(10), 
    PRODUCTPRICE FLOAT(10), 
    ISDELETED BOOL,
	PRIMARY KEY (ORDER_ID, PRODUCT_ID)
)ENGINE = INNODB;

create table deliveries 
(
	DELIVERY_ID CHAR(100)  NOT NULL,
    ORDER_ID CHAR(100),
    CLIENT_ID CHAR(100), 
    DELIVERY_DAY DATE, 
    DELIVERY_STATUS ENUM("FAILED","PACKAGING","DELIVERING","SUCCEED","RETURN"),
	NOTE VARCHAR(50),
    MANAGER CHAR(100),
    ISDELETED BOOL,
	PRIMARY KEY (DELIVERY_ID)
)ENGINE = INNODB;

create table bills
(
	ORDER_ID CHAR(100) NOT NULL, 
    PAYMENT VARCHAR(50),
    DISCOUNT FLOAT(10),
    TAX FLOAT(10),
    SHIPPING_COST FLOAT(10),
    ISDELETED BOOL,
	PRIMARY KEY (ORDER_ID)
)ENGINE = INNODB;



ALTER TABLE products ADD CONSTRAINT fk_p_ad FOREIGN KEY(IMPORTER) REFERENCES admins(ADMIN_ID);
ALTER TABLE products ADD CONSTRAINT fk_p_ca FOREIGN KEY(CATEGORY) REFERENCES categories(CATEGORY_ID);

ALTER TABLE carts ADD CONSTRAINT fk_c_cl FOREIGN KEY(CLIENT_ID) REFERENCES clients(CLIENT_ID);
ALTER TABLE carts ADD CONSTRAINT fk_c_pd FOREIGN KEY(PRODUCT_ID) REFERENCES products(PRODUCT_ID);

ALTER TABLE reviews ADD CONSTRAINT fk_rv_cl FOREIGN KEY(CLIENT_ID) REFERENCES clients(CLIENT_ID);
ALTER TABLE reviews ADD CONSTRAINT fk_rv_pd FOREIGN KEY(PRODUCT_ID) REFERENCES products(PRODUCT_ID);

ALTER TABLE wishlists ADD CONSTRAINT fk_w_cl FOREIGN KEY(CLIENT_ID) REFERENCES clients(CLIENT_ID);
ALTER TABLE wishlists ADD CONSTRAINT fk_w_pd FOREIGN KEY(PRODUCT_ID) REFERENCES products(PRODUCT_ID);

ALTER TABLE orders ADD CONSTRAINT fk_o_cl FOREIGN KEY(CLIENT_ID) REFERENCES clients(CLIENT_ID);
ALTER TABLE orders ADD CONSTRAINT fk_o_a FOREIGN KEY(MANAGER) REFERENCES admins(ADMIN_ID);

ALTER TABLE orders_detail ADD CONSTRAINT fk_od_o FOREIGN KEY(ORDER_ID) REFERENCES orders(ORDER_ID);
ALTER TABLE orders_detail ADD CONSTRAINT fk_od_p FOREIGN KEY(PRODUCT_ID) REFERENCES products(PRODUCT_ID);

ALTER TABLE deliveries ADD CONSTRAINT fk_d_o FOREIGN KEY(ORDER_ID) REFERENCES orders(ORDER_ID);
ALTER TABLE deliveries ADD CONSTRAINT fk_d_cl FOREIGN KEY(CLIENT_ID) REFERENCES clients(CLIENT_ID);
ALTER TABLE deliveries ADD CONSTRAINT fk_d_a FOREIGN KEY(MANAGER) REFERENCES admins(ADMIN_ID);

ALTER TABLE bills ADD CONSTRAINT fk_b_o FOREIGN KEY(ORDER_ID) REFERENCES orders(ORDER_ID);

#----------------------------------ADMINS
INSERT INTO ADMINS VALUES ("a1ba61aa-6de5-11ec-ae9b-651e6ab7568b","Maria","Iris","FEMALE","1994/1/1","mariairis@gmail.com","/assets/images/accounts/face1.jpg","user01","pass123",false,false);
INSERT INTO ADMINS VALUES ("a2ba61aa-6de5-11ec-ae9b-651e6ab7568b","Colin","Delano","MALE","1992/10/22","colindelano@gmail.com","/assets/images/accounts/face2.jpg","user02","pass123",false,false);
INSERT INTO ADMINS VALUES ("a3ba61aa-6de5-11ec-ae9b-651e6ab7568b","Bryce","Graham","MALE","1988/3/14","brycegraham@gmail.com","/assets/images/accounts/face3.jpg","user03","pass123",false,false);
INSERT INTO ADMINS VALUES ("a4ba61aa-6de5-11ec-ae9b-651e6ab7568b","Amie","Charla","FEMALE","1991/9/8","amiecharla@gmail.com","/assets/images/accounts/face4.jpg","user04","pass123",false,false);

#----------------------------------CLIENTS
INSERT INTO CLIENTS VALUES ("c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","Diana","Granet","Female","2000/12/12","0909354345","/assets/images/clients/client01.jpg","dianagranet@gmail.com","$2b$10$ynlDhgqvyByZBD7w2E.6s.2JjKvRpaiVWryVJoPJveNPCHH4AG5ri",false,false);
INSERT INTO CLIENTS VALUES ("c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","Nicole","Quinn","Female","1995/1/6","0898161616","/assets/images/clients/client02.jpg","nicolequinn@gmail.com","$2b$10$ynlDhgqvyByZBD7w2E.6s.2JjKvRpaiVWryVJoPJveNPCHH4AG5ri",false,false);
INSERT INTO CLIENTS VALUES ("c3ba61aa-6de5-11ec-ae9b-651e6ab7568b","Davis","Lambert","Male","1990/4/24","0797645456","/assets/images/clients/client03.jpg","davislambert@gmail.com","$2b$10$ynlDhgqvyByZBD7w2E.6s.2JjKvRpaiVWryVJoPJveNPCHH4AG5ri",false,false);
INSERT INTO CLIENTS VALUES ("c4ba61aa-6de5-11ec-ae9b-651e6ab7568b","Cecelia","Brandy","Female","1989/1/18","0808483834","/assets/images/clients/client04.jpg","ceceliabrandy@gmail.com","$2b$10$ynlDhgqvyByZBD7w2E.6s.2JjKvRpaiVWryVJoPJveNPCHH4AG5ri",false,false);
INSERT INTO CLIENTS VALUES ("c5ba61aa-6de5-11ec-ae9b-651e6ab7568b","Aria","Brandy","Female","1989/1/12","0803483834","/assets/images/clients/client04.jpg","arialiabrandy@gmail.com","$2b$10$ynlDhgqvyByZBD7w2E.6s.2JjKvRpaiVWryVJoPJveNPCHH4AG5ri",false,true);
#----------------------------------CATEGORIES
INSERT INTO categories VALUES ("c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","Fruits",false);
INSERT INTO categories VALUES ("c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","Vegetable",false);
INSERT INTO categories VALUES ("c3ba61aa-6de5-11ec-ae9b-651e6ab7568b","Podded Vegetable",false);
INSERT INTO categories VALUES ("c4ba61aa-6de5-11ec-ae9b-651e6ab7568b","Bulbs",false);
INSERT INTO categories VALUES ("c5ba61aa-6de5-11ec-ae9b-651e6ab7568b","Root and tuberous",false);

#----------------------------------PRODUCT
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b01","/assets/images/products/PD-01.jpg","CARROT","c5ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",50,50,40,"2021-11-5","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"carrot carrot carrot carrot carrot carrot carrot carrot carrot carrot carrot carrot carrot carrot carrot",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b02","/assets/images/products/PD-02.jpg","POTATO","c5ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",28,62,70,"2021-11-10","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"potato potato potato potato potato potato potato potato potato potato potato potato potato potato potato",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b03","/assets/images/products/PD-03.jpg","APPLE","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","OUT STOCK",0,90,100,"2021-3-31","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"apple apple apple apple apple apple apple apple apple apple apple apple apple apple apple",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b04","/assets/images/products/PD-04.jpg","TOMATO","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",33,67,30,"2021-10-28","a3ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"tomato tomato tomato tomato tomato tomato tomato tomato tomato tomato tomato tomato tomato tomato tomato",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b05","/assets/images/products/PD-05.jpg","GREEN ONION 200g","c4ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",50,45,40,"2021-11-5","a3ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"green onion green onion green onion green onion green onion green onion green onion green onion green onion green onion green onion green onion green onion green onion green onion", false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b06","/assets/images/products/PD-06.jpg","GREEN ONION 500g","c4ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",25,45,75,"2021-11-5","a3ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"green onion green onion green onion green onion green onion green onion green onion green onion green onion green onion green onion green onion green onion green onion green onion",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b07","/assets/images/products/PD-07.jpg","CAULIFLOWER","c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",20,80,35,"2021-10-28","a2ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"cauliflower cauliflower cauliflower cauliflower cauliflower cauliflower cauliflower cauliflower cauliflower cauliflower cauliflower cauliflower cauliflower cauliflower cauliflower",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b08","/assets/images/products/PD-08.jpg","EGGPLANT","c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",50,50,25,"2021-11-5","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"eggplant eggplant eggplant eggplant eggplant eggplant eggplant eggplant eggplant eggplant eggplant eggplant eggplant eggplant eggplant",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b09","/assets/images/products/PD-09.jpg","PUMPKIN","c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",38,62,35,"2021-11-10","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"pumpkin pumpkin pumpkin pumpkin pumpkin pumpkin pumpkin pumpkin pumpkin pumpkin pumpkin pumpkin pumpkin pumpkin pumpkin",false);


INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b10","/assets/images/products/PD-10.jpg","PEAS 200g","c3ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",100,0,20,"2021-11-10","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"peas peas peas peas peas peas peas peas peas peas peas peas peas peas peas",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b11","/assets/images/products/PD-11.jpg","PEAS 500g","c3ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",70,30,40,"2021-11-10","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"peas peas peas peas peas peas peas peas peas peas peas peas peas peas peas",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b12","/assets/images/products/PD-12.jpg","LEMON 350g","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",77,23,25,"2021-10-28","a3ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"lemon lemon lemon lemon lemon lemon lemon lemon lemon lemon lemon lemon lemon lemon lemon",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b13","/assets/images/products/PD-13.jpg","GARLIC 150g","c4ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",122,38,10,"2021-11-10","a3ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"garlic garlic garlic garlic garlic garlic garlic garlic garlic garlic garlic garlic garlic garlic garlic",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b14","/assets/images/products/PD-14.jpg","SHALLOT 150g","c4ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",110,40,15,"2021-11-10","a3ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"shallot shallot shallot shallot shallot shallot shallot shallot shallot shallot shallot shallot shallot shallot shallot",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b15","/assets/images/products/PD-15.jpg","GREEN BEANS 200g","c3ba61aa-6de5-11ec-ae9b-651e6ab7568b","OUT STOCK",0,99,30,"2021-3-31","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"green beans green beans green beans green beans green beans green beans green beans green beans green beans green beans green beans green beans green beans green beans green beans",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b16","/assets/images/products/PD-16.jpg","BLACK BEANS 200g","c3ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",38,62,30,"2021-10-28","a2ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"black beans black beans black beans black beans black beans black beans black beans black beans black beans black beans black beans black beans black beans black beans black beans",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b17","/assets/images/products/PD-17.jpg","BANANA","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",60,50,40,"2021-3-31","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"banana banana banana banana banana banana banana banana banana banana banana banana banana banana banana",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b18","/assets/images/products/PD-18.jpg","GREEN BEANS 500g","c3ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",9,91,70,"2021-3-31","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"green beans green beans green beans green beans green beans green beans green beans green beans green beans green beans green beans green beans green beans green beans green beans",false);


INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b19","/assets/images/products/PD-19.jpg","BLACK BEANS 500g","c3ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",16,84,70,"2021-10-28","a2ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"black beans black beans black beans black beans black beans black beans black beans black beans black beans black beans black beans black beans black beans black beans black beans",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b20","/assets/images/products/PD-20.jpg","PINEAPPLE","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",15,75,38,"2021-11-10","a2ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"pineapple pineapple pineapple pineapple pineapple pineapple pineapple pineapple pineapple pineapple pineapple pineapple pineapple pineapple pineapple",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b21","/assets/images/products/PD-21.jpg","SOYBEAN 200g","c3ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",65,25,19,"2021-3-31","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"soybean soybean soybean soybean soybean soybean soybean soybean soybean soybean soybean soybean soybean soybean soybean",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b22","/assets/images/products/PD-22.jpg","SOYBEAN 500g","c3ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",40,50,40,"2021-3-31","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"soybean soybean soybean soybean soybean soybean soybean soybean soybean soybean soybean soybean soybean soybean soybean",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b23","/assets/images/products/PD-23.jpg","PEAR","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",33,77,30,"2021-10-28","a2ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"pear pear pear pear pear pear pear pear pear pear pear pear pear pear pear",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b24","/assets/images/products/PD-24.jpg","LIME 200g","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","OUT STOCK",0,110,25,"2021-10-28","a2ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"lime lime lime lime lime lime lime lime lime lime lime lime lime lime lime",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b25","/assets/images/products/PD-25.jpg","CABBAGE","c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",8,92,45,"2021-11-10","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"cabbage cabbage cabbage cabbage cabbage cabbage cabbage cabbage cabbage cabbage cabbage cabbage cabbage cabbage cabbage",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b26","/assets/images/products/PD-26.jpg","MUSHROOM 200g","c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",20,80,50,"2021-11-10","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"mushroom mushroom mushroom mushroom mushroom mushroom mushroom mushroom mushroom mushroom mushroom mushroom mushroom mushroom mushroom",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b27","/assets/images/products/PD-27.jpg","MUSHROOM 500g","c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",30,70,110,"2021-11-10","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"mushroom mushroom mushroom mushroom mushroom mushroom mushroom mushroom mushroom mushroom mushroom mushroom mushroom mushroom mushroom",false);


INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b28","/assets/images/products/PD-28.jpg","CORN","c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",56,44,10,"2021-3-31","a3ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"corn corn corn corn corn corn corn corn corn corn corn corn corn corn corn",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b29","/assets/images/products/PD-29.jpg","CELERY 200g","c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",13,107,30,"2021-10-28","a3ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"celery celery celery celery celery celery celery celery celery celery celery celery celery celery celery",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b30","/assets/images/products/PD-30.jpg","STRAWBERRY 200g","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",17,83,60,"2021-11-10","a3ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"strawberry strawberry strawberry strawberry strawberry strawberry strawberry strawberry strawberry strawberry strawberry strawberry strawberry strawberry strawberry",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b31","/assets/images/products/PD-31.jpg","CHERRY 200g","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",28,72,55,"2021-11-10","a3ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"cherry cherry cherry cherry cherry cherry cherry cherry cherry cherry cherry cherry cherry cherry cherry",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b32","/assets/images/products/PD-32.jpg","STRAWBERRY 500g","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",20,60,120,"2021-11-10","a3ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"strawberry strawberry strawberry strawberry strawberry strawberry strawberry strawberry strawberry strawberry strawberry strawberry strawberry strawberry strawberry",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b33","/assets/images/products/PD-33.jpg","CHERRY 500g","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",3,107,120,"2021-11-10","a3ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"cherry cherry cherry cherry cherry cherry cherry cherry cherry cherry cherry cherry cherry cherry cherry",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b34","/assets/images/products/PD-34.jpg","BEET","c5ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",50,40,40,"2021-11-5","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"beet beet beet beet beet beet beet beet beet beet beet beet beet beet beet",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b35","/assets/images/products/PD-35.jpg","SWEET POTATO","c5ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",50,50,35,"2021-11-10","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"sweet potato sweet potato sweet potato sweet potato sweet potato sweet potato sweet potato sweet potato sweet potato sweet potato sweet potato sweet potato sweet potato sweet potato sweet potato",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b36","/assets/images/products/PD-36.jpg","GREEN GRAPES","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",19,91,35,"2021-3-31","a2ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"green grapes green grapes green grapes green grapes green grapes green grapes green grapes green grapes green grapes green grapes green grapes green grapes green grapes green grapes green grapes",false);


INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b37","/assets/images/products/PD-37.jpg","CHICKPEA 200g","c3ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",43,57,30,"2021-10-28","a2ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"chichpea chichpea chichpea chichpea chichpea chichpea chichpea chichpea chichpea chichpea chichpea chichpea chichpea chichpea chichpea",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b38","/assets/images/products/PD-38.jpg","RED ONION 200g","c4ba61aa-6de5-11ec-ae9b-651e6ab7568b","OUT STOCK",6,94,55,"2021-11-10","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"red onion red onion red onion red onion red onion red onion red onion red onion red onion red onion red onion red onion red onion red onion red onion",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b39","/assets/images/products/PD-39.jpg","TARO","c5ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",12,88,20,"2021-11-10","a4ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"taro taro taro taro taro taro taro taro taro taro taro taro taro taro taro",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b40","/assets/images/products/PD-40.jpg","APRICOT","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",22,78,40,"2021-11-10","a4ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"apricot apricot apricot apricot apricot apricot apricot apricot apricot apricot apricot apricot apricot apricot apricot",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b41","/assets/images/products/PD-41.jpg","TURNIPS","c5ba61aa-6de5-11ec-ae9b-651e6ab7568b","OUT STOCK",0,101,30,"2021-3-31","a4ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"carrot carrot carrot carrot carrot carrot carrot carrot carrot carrot carrot carrot carrot carrot carrot",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b42","/assets/images/products/PD-42.jpg","PAPAYA","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",33,67,30,"2021-10-28","a2ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"papaya papaya papaya papaya papaya papaya papaya papaya papaya papaya papaya papaya papaya papaya papaya",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b43","/assets/images/products/PD-43.jpg","CUCUMBER","c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",50,50,25,"2021-11-5","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"cucumber cucumber cucumber cucumber cucumber cucumber cucumber cucumber cucumber cucumber cucumber cucumber cucumber cucumber cucumber",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b44","/assets/images/products/PD-44.jpg","BELL PEPPER 350g","c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",28,72,25,"2021-11-10","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"bell pepper bell pepper bell pepper bell pepper bell pepper bell pepper bell pepper bell pepper bell pepper bell pepper bell pepper bell pepper bell pepper bell pepper bell pepper",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b45","/assets/images/products/PD-45.jpg","MANGO","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",50,60,50,"2021-11-5","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"mango mango mango mango mango mango mango mango mango mango mango mango mango mango mango",false);


INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b46","/assets/images/products/PD-46.jpg","BLUEBERRY 200g","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",28,62,50,"2021-11-10","a4ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"blueberry blueberry blueberry blueberry blueberry blueberry blueberry blueberry blueberry blueberry blueberry blueberry blueberry blueberry blueberry",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b47","/assets/images/products/PD-47.jpg","BLACKBERRY 200g","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",18,62,60,"2021-11-10","a3ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"blackberry blackberry blackberry blackberry blackberry blackberry blackberry blackberry blackberry blackberry blackberry blackberry blackberry blackberry blackberry",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b48","/assets/images/products/PD-48.jpg","BLUEBERRY 500g","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",10,80,110,"2021-11-10","a4ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"blueberry blueberry blueberry blueberry blueberry blueberry blueberry blueberry blueberry blueberry blueberry blueberry blueberry blueberry blueberry",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b49","/assets/images/products/PD-49.jpg","BLACKBERRY 500g","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",7,103,125,"2021-11-10","a3ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"blackberry blackberry blackberry blackberry blackberry blackberry blackberry blackberry blackberry blackberry blackberry blackberry blackberry blackberry blackberry",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b50","/assets/images/products/PD-50.jpg","PEACH","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",50,55,45,"2021-11-5","a4ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"peach peach peach peach peach peach peach peach peach peach peach peach peach peach peach",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b51","/assets/images/products/PD-51.jpg","ORANGE","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",28,72,30,"2021-11-10","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"orange orange orange orange orange orange orange orange orange orange orange orange orange orange orange",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b52","/assets/images/products/PD-52.jpg","HOT PEPPER 100g","c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",69,21,9,"2021-3-31","a4ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"hot pepper hot pepper hot pepper hot pepper hot pepper hot pepper hot pepper hot pepper hot pepper hot pepper hot pepper hot pepper hot pepper hot pepper hot pepper",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b53","/assets/images/products/PD-53.jpg","BROCCOLI","c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",5,100,40,"2021-3-31","a4ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"broccoli broccoli broccoli broccoli broccoli broccoli broccoli broccoli broccoli broccoli broccoli broccoli broccoli broccoli broccoli",false);
INSERT INTO PRODUCTS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b54","/assets/images/products/PD-54.jpg","WATERMELON","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","IN STOCK",12,88,50,"2021-11-5","a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",
"watermelon watermelon watermelon watermelon watermelon watermelon watermelon watermelon watermelon watermelon watermelon watermelon watermelon watermelon watermelon",false);

#----------------------------------REVIEWS
#--INSERT INTO REVIEWS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b01","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","GOOOOOOOOD","2020-12-29",false);
INSERT INTO REVIEWS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b01","c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","VERYYYYYYYYYY GOOOOOOOOD","2020-12-29",false);
INSERT INTO REVIEWS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b01","c3ba61aa-6de5-11ec-ae9b-651e6ab7568b","SUPERRRRRRRRR GOOOOOOOOD","2020-12-30",false);
INSERT INTO REVIEWS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b01","c4ba61aa-6de5-11ec-ae9b-651e6ab7568b","EXTREMELY ULTRAAAAAAAAA GOOOOOOOOD","2020-12-31",false);
INSERT INTO REVIEWS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b02","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","GOOOOOOOOD","2020-12-31",false);
INSERT INTO REVIEWS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b03","c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","VERYYYYYYYYYY GOOOOOOOOD","2020-12-29",false);
INSERT INTO REVIEWS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b04","c3ba61aa-6de5-11ec-ae9b-651e6ab7568b","SUPERRRRRRRRR GOOOOOOOOD","2020-12-29",false);
INSERT INTO REVIEWS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b04","c4ba61aa-6de5-11ec-ae9b-651e6ab7568b","EXTREMELY ULTRAAAAAAAAA GOOOOOOOOD","2020-12-30",false);
INSERT INTO REVIEWS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b04","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","GOOOOOOOOD","2020-12-31",false);
INSERT INTO REVIEWS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b05","c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","VERYYYYYYYYYY GOOOOOOOOD","2020-12-29",false);
INSERT INTO REVIEWS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b06","c3ba61aa-6de5-11ec-ae9b-651e6ab7568b","SUPERRRRRRRRR GOOOOOOOOD","2020-12-28",false);
INSERT INTO REVIEWS VALUES ("ba61aa-6de5-11ec-ae9b-651e6ab7568b07","c4ba61aa-6de5-11ec-ae9b-651e6ab7568b","EXTREMELY ULTRAAAAAAAAA GOOOOOOOOD","2020-12-28",false);
 

#----------------------------------CARTS
INSERT INTO CARTS VALUES ("c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b01",2,false);
INSERT INTO CARTS VALUES ("c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b29",2,false);
INSERT INTO CARTS VALUES ("c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b02",5,false);
INSERT INTO CARTS VALUES ("c3ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b01",5,false);
INSERT INTO CARTS VALUES ("c4ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b05",10,false);
INSERT INTO CARTS VALUES ("c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b11",2,false);
INSERT INTO CARTS VALUES ("c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b02",5,false);
INSERT INTO CARTS VALUES ("c4ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b45",10,false);

#----------------------------------WISHLISTS
INSERT INTO WISHLISTS VALUES ("c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b01",false);
INSERT INTO WISHLISTS VALUES ("c4ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b03",false);
INSERT INTO WISHLISTS VALUES ("c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b03",false);
INSERT INTO WISHLISTS VALUES ("c3ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b05",false);

#----------------------------------ORDERS
INSERT INTO ORDERS VALUES ("o1ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-10 18:34:09","23-5 Nguyen Van Cu, Phuong 1, Quan 5, Ho Chi Minh", "a4ba61aa-6de5-11ec-ae9b-651e6ab7568b", "c3ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO ORDERS VALUES ("o2ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-10 19:02:31","62 Cong Hoa, Phuong 4, Quan Tan Binh, Ho Chi Minh", "a2ba61aa-6de5-11ec-ae9b-651e6ab7568b", "c1ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO ORDERS VALUES ("o3ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-11 07:10:54","23-5 Nguyen Van Cu, Phuong 1, Quan 5, Ho Chi Minh", "a4ba61aa-6de5-11ec-ae9b-651e6ab7568b", "c2ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO ORDERS VALUES ("o4ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-13 10:27:52","120 Hoang Hoa Tham, Phuong 2, Quan 4, Ho Chi Minh", "a2ba61aa-6de5-11ec-ae9b-651e6ab7568b", "c4ba61aa-6de5-11ec-ae9b-651e6ab7568b",true);
INSERT INTO ORDERS VALUES ("o5ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-14 14:18:02","62 Cong Hoa, Phuong 4, Quan Tan Binh, Ho Chi Minh", "a1ba61aa-6de5-11ec-ae9b-651e6ab7568b", "c1ba61aa-6de5-11ec-ae9b-651e6ab7568b",true);
INSERT INTO ORDERS VALUES ("o6ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-14 16:44:27","23-5 Nguyen Van Cu, Phuong 1, Quan 5, Ho Chi Minh", "a3ba61aa-6de5-11ec-ae9b-651e6ab7568b", "c3ba61aa-6de5-11ec-ae9b-651e6ab7568b",true);
INSERT INTO ORDERS VALUES ("o7ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-15 2:02:31","62 Cong Hoa, Phuong 4, Quan Tan Binh, Ho Chi Minh", "a2ba61aa-6de5-11ec-ae9b-651e6ab7568b", "c1ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO ORDERS VALUES ("o8ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-15 18:34:09","23-5 Nguyen Van Cu, Phuong 1, Quan 5, Ho Chi Minh", "a3ba61aa-6de5-11ec-ae9b-651e6ab7568b", "c3ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO ORDERS VALUES ("o9ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-16 19:02:31","62 Cong Hoa, Phuong 4, Quan Tan Binh, Ho Chi Minh", "a2ba61aa-6de5-11ec-ae9b-651e6ab7568b", "c2ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO ORDERS VALUES ("o10ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-17 07:10:54","23-5 Nguyen Van Cu, Phuong 1, Quan 5, Ho Chi Minh", "a4ba61aa-6de5-11ec-ae9b-651e6ab7568b", "c2ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO ORDERS VALUES ("o11ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-15 2:02:31","62 Cong Hoa, Phuong 4, Quan Tan Binh, Ho Chi Minh", "a2ba61aa-6de5-11ec-ae9b-651e6ab7568b", "c1ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO ORDERS VALUES ("o12ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-15 18:34:09","23-5 Nguyen Van Cu, Phuong 1, Quan 5, Ho Chi Minh", "a3ba61aa-6de5-11ec-ae9b-651e6ab7568b", "c1ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);

#----------------------------------ORDERS DETAIL
INSERT INTO ORDERS_DETAIL VALUES ("o1ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b01",5,200,false);
INSERT INTO ORDERS_DETAIL VALUES ("o1ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b02",2,140,false); 
INSERT INTO ORDERS_DETAIL VALUES ("o2ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b05",7,280,false);
INSERT INTO ORDERS_DETAIL VALUES ("o3ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b02",4,280,false);
INSERT INTO ORDERS_DETAIL VALUES ("o4ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b01",5,200,false);
INSERT INTO ORDERS_DETAIL VALUES ("o4ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b02",2,140,false); 
INSERT INTO ORDERS_DETAIL VALUES ("o4ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b05",7,280,false);
INSERT INTO ORDERS_DETAIL VALUES ("o5ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b07",5,175,false);
INSERT INTO ORDERS_DETAIL VALUES ("o6ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b02",4,280,false);
INSERT INTO ORDERS_DETAIL VALUES ("o7ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b12",1,50,false);
INSERT INTO ORDERS_DETAIL VALUES ("o10ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b12",1,50,false);
INSERT INTO ORDERS_DETAIL VALUES ("o7ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b42",1,30,false);
INSERT INTO ORDERS_DETAIL VALUES ("o7ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b30",1,60,false);
INSERT INTO ORDERS_DETAIL VALUES ("o8ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b37",1,30,false);
INSERT INTO ORDERS_DETAIL VALUES ("o8ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b50",1,45,false);
INSERT INTO ORDERS_DETAIL VALUES ("o8ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b10",9,180,false);
INSERT INTO ORDERS_DETAIL VALUES ("o9ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b09",1,35,false);
INSERT INTO ORDERS_DETAIL VALUES ("o10ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b28",1,10,false);
INSERT INTO ORDERS_DETAIL VALUES ("o10ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b14",1,15,false);
INSERT INTO ORDERS_DETAIL VALUES ("o11ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b10",9,180,false);
INSERT INTO ORDERS_DETAIL VALUES ("o12ba61aa-6de5-11ec-ae9b-651e6ab7568b","ba61aa-6de5-11ec-ae9b-651e6ab7568b09",2,70,false);

#----------------------------------DELIVERIES
INSERT INTO DELIVERIES VALUES ("d1ba61aa-6de5-11ec-ae9b-651e6ab7568b","o2ba61aa-6de5-11ec-ae9b-651e6ab7568b","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-11","FAILED",null,"a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO DELIVERIES VALUES ("d2ba61aa-6de5-11ec-ae9b-651e6ab7568b","o2ba61aa-6de5-11ec-ae9b-651e6ab7568b","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-12","SUCCEED",null,"a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO DELIVERIES VALUES ("d3ba61aa-6de5-11ec-ae9b-651e6ab7568b","o1ba61aa-6de5-11ec-ae9b-651e6ab7568b","c3ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-12","SUCCEED",null,"a3ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO DELIVERIES VALUES ("d4ba61aa-6de5-11ec-ae9b-651e6ab7568b","o3ba61aa-6de5-11ec-ae9b-651e6ab7568b","c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-13","SUCCEED",null,"a4ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO DELIVERIES VALUES ("d5ba61aa-6de5-11ec-ae9b-651e6ab7568b","o11ba61aa-6de5-11ec-ae9b-651e6ab7568b","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-11","PACKAGING",null,"a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO DELIVERIES VALUES ("d6ba61aa-6de5-11ec-ae9b-651e6ab7568b","o12ba61aa-6de5-11ec-ae9b-651e6ab7568b","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-11","SUCCEED",null,"a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO DELIVERIES VALUES ("d7ba61aa-6de5-11ec-ae9b-651e6ab7568b","o4ba61aa-6de5-11ec-ae9b-651e6ab7568b","c4ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-15","RETURN","damaged goods","a4ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO DELIVERIES VALUES ("d8ba61aa-6de5-11ec-ae9b-651e6ab7568b","o5ba61aa-6de5-11ec-ae9b-651e6ab7568b","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-16","RETURN","order is canceled","a2ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO DELIVERIES VALUES ("d9ba61aa-6de5-11ec-ae9b-651e6ab7568b","o6ba61aa-6de5-11ec-ae9b-651e6ab7568b","c3ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-17","RETURN","order is canceled","a3ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO DELIVERIES VALUES ("d10ba61aa-6de5-11ec-ae9b-651e6ab7568b","o7ba61aa-6de5-11ec-ae9b-651e6ab7568b","c1ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-20","PACKAGING",null,"a3ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO DELIVERIES VALUES ("d11ba61aa-6de5-11ec-ae9b-651e6ab7568b","o8ba61aa-6de5-11ec-ae9b-651e6ab7568b","c3ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-21","PACKAGING",null,"a4ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO DELIVERIES VALUES ("d12ba61aa-6de5-11ec-ae9b-651e6ab7568b","o9ba61aa-6de5-11ec-ae9b-651e6ab7568b","c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-21","DELIVERING",null,"a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);
INSERT INTO DELIVERIES VALUES ("d13ba61aa-6de5-11ec-ae9b-651e6ab7568b","o10ba61aa-6de5-11ec-ae9b-651e6ab7568b","c2ba61aa-6de5-11ec-ae9b-651e6ab7568b","2021-11-22","DELIVERING",null,"a1ba61aa-6de5-11ec-ae9b-651e6ab7568b",false);

#----------------------------------BILLS
INSERT INTO BILLS VALUES ("o2ba61aa-6de5-11ec-ae9b-651e6ab7568b","cash on delivery", 40, 2, 0,false);
INSERT INTO BILLS VALUES ("o4ba61aa-6de5-11ec-ae9b-651e6ab7568b","cash on delivery", 10, 2, 0,false);
INSERT INTO BILLS VALUES ("o1ba61aa-6de5-11ec-ae9b-651e6ab7568b","credit card", 10, 4, 10,false);
INSERT INTO BILLS VALUES ("o3ba61aa-6de5-11ec-ae9b-651e6ab7568b","credit card", 20, 2, 10,false);
INSERT INTO BILLS VALUES ("o5ba61aa-6de5-11ec-ae9b-651e6ab7568b","cash on delivery", 10, 2, 0,false);
INSERT INTO BILLS VALUES ("o6ba61aa-6de5-11ec-ae9b-651e6ab7568b","credit card", 10, 4, 0,false);
INSERT INTO BILLS VALUES ("o7ba61aa-6de5-11ec-ae9b-651e6ab7568b","credit card", 20, 2, 10,false);
INSERT INTO BILLS VALUES ("o8ba61aa-6de5-11ec-ae9b-651e6ab7568b","cash on delivery", 10, 2, 20,false);
INSERT INTO BILLS VALUES ("o9ba61aa-6de5-11ec-ae9b-651e6ab7568b","paypal", 10, 4, 0,false);
INSERT INTO BILLS VALUES ("o10ba61aa-6de5-11ec-ae9b-651e6ab7568b","cash on delivery", 20, 2, 10,false);
INSERT INTO BILLS VALUES ("o11ba61aa-6de5-11ec-ae9b-651e6ab7568b","cash on delivery", 0, 2, 10,false);
INSERT INTO BILLS VALUES ("o12ba61aa-6de5-11ec-ae9b-651e6ab7568b","cash on delivery", 0, 2, 20,false);

