CREATE TABLE aipgroup.product (
product_id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
product_nm VARCHAR(30) NOT NULL,
description VARCHAR(255),
reg_date TIMESTAMP
);

CREATE TABLE aipgroup.flavor (
flavor_id INT(6)  UNSIGNED AUTO_INCREMENT PRIMARY KEY,
product_id INT(6) UNSIGNED,
flavor_nm VARCHAR(30) NOT NULL,
reg_date TIMESTAMP,
INDEX i_prod_id (product_id),
    FOREIGN KEY (product_id)
        REFERENCES aipgroup.product(product_id)
        ON DELETE CASCADE
);

CREATE TABLE aipgroup.ingredient (
ingred_id INT(6)  UNSIGNED AUTO_INCREMENT PRIMARY KEY,
ingred_nm VARCHAR(30) NOT NULL,
reg_date TIMESTAMP
);

CREATE TABLE aipgroup.ingred_qty (
no INT(6)  UNSIGNED AUTO_INCREMENT PRIMARY KEY,
flavor_id INT(6) UNSIGNED  NOT NULL,
ingred_id INT(6)  UNSIGNED  NOT NULL,
quantity decimal(6,2) NOT NULL,
unit varchar(30), 
reg_date TIMESTAMP,

    INDEX(flavor_id, ingred_id),

    FOREIGN KEY (flavor_id)
      REFERENCES aipgroup.flavor(flavor_id)
        ON DELETE CASCADE,
        
    FOREIGN KEY (ingred_id)
      REFERENCES aipgroup.ingredient(ingred_id)
        ON DELETE CASCADE
);

--drop table aipgroup.ingred_qty;

insert into aipgroup.product (product_nm , description , reg_date) values ('Chicken Pizza', 'Best Pizza in Sydney', Now());
insert into aipgroup.flavor (product_id , flavor_nm, reg_date) values (1, 'Normal', Now());
insert into aipgroup.flavor (product_id , flavor_nm, reg_date) values (1, 'Spicy', Now());
insert into aipgroup.ingredient (ingred_nm, reg_date) values ('Onion', Now());
insert into aipgroup.ingredient (ingred_nm, reg_date) values ('Cheese', Now());
insert into aipgroup.ingredient (ingred_nm, reg_date) values ('Tomato', Now());

insert into aipgroup.ingred_qty (flavor_id, ingred_id, quantity, unit, reg_date) values (1, 1, 100.0, 'g', Now());
insert into aipgroup.ingred_qty (flavor_id, ingred_id, quantity, unit, reg_date) values (1, 2, 50.0, 'g', Now());
insert into aipgroup.ingred_qty (flavor_id, ingred_id, quantity, unit, reg_date) values (1, 3, 300.0, '', Now());

insert into aipgroup.ingred_qty (flavor_id, ingred_id, quantity, unit, reg_date) values (2, 1, 120.0, 'g', Now());
insert into aipgroup.ingred_qty (flavor_id, ingred_id, quantity, unit, reg_date) values (2, 2, 80.0, 'g', Now());
insert into aipgroup.ingred_qty (flavor_id, ingred_id, quantity, unit, reg_date) values (2, 3, 320.0, '', Now());



select * from aipgroup.product;
select * from aipgroup.flavor;
select * from aipgroup.ingredient;
select * from aipgroup.ingred_qty;

-- Get Product
SELECT p.product_id  , p.product_nm FROM aipgroup.product as p ;

-- Get Flavor
SELECT f.flavor_id  , f.flavor_nm FROM aipgroup.flavor as f where f.product_id = 1 -- product_id
;

-- Get Ingredient
SELECT i.ingred_id
  , i.ingred_nm
  , q.quantity
  , q.unit
from aipgroup.ingredient as i
  , aipgroup.ingred_qty as q
where i.ingred_id = q.ingred_id
and   q.flavor_id = 1 -- flavor_id
;
