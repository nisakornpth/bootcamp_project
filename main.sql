-- Restaurant Owners
-- 5 Tables
-- 1X Fact, 4X Dimension
-- search google, how to add foreign key
-- write SQL 3 queries analyze data
-- 1 subquery/ with

-- TABLE 01 menus
CREATE TABLE menus (
  menu_id INT PRIMARY KEY,
  menu_createdate date,
  menu_detail TEXT,
  menu_price REAL
);

INSERT INTO menus values
  (1, '2022-12-12', 'Fried rice',                         60),
  (2, '2022-12-12', 'Stewed pork leg on rice',            65),
  (3, '2022-12-12', 'Steamed spring roll',                75),
  (4, '2022-12-12', 'Sour prawn soup ',                   150),
  (5, '2022-12-12', 'Rice porridge',                      55),
  (6, '2022-12-12', 'Chicken with cashew nuts',           150),
  (7, '2022-12-12', 'Oyster omelette',                    120),
  (8, '2022-12-12', 'Sweet and sour fish',                150),
  (9, '2022-12-12', 'Seaweed Soup',                       120),
  (10, '2022-12-12','Minced pork omelet over rice ',      55),
  (11, '2022-12-12','Fried tilapia with spicy sauce ',    150);

INSERT INTO menus values
  (12, '2022-12-15', 'Fried chicken',                             70),
  (13, '2022-12-15', 'Grilled Shrimp',                            150),
  (14, '2022-12-15', 'Steamed rice topped with chicken',          65),
  (15, '2022-12-15', 'Dumplings',                                 60);

-- sqlite command
.mode column
.header on

SELECT * FROM menus;

-- TABLE 02 menus_type
CREATE TABLE menus_type (
  menu_id INT,
  menu_type TEXT
);

INSERT INTO menus_type values
  (1, 'Main courses'),
  (2, 'Main courses '),
  (3, 'Appetizers'),
  (4, 'Soup or Curry  '),
  (5, 'Main courses'),
  (6, 'Dished'),
  (7, 'Dished'),
  (8, 'Dished'),
  (9, 'Soup or Curry '),
  (10, 'Main courses '),
  (11, 'Dished'),
  (12, 'Appetizers '),
  (13, 'Appetizers '),
  (14, 'Main courses'),
  (15, 'Appetizers ');

SELECT * FROM menus_type;

-- Table 03 orders
CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  order_date date,
  order_type
);

INSERT INTO orders values
  (1, '2022-02-02', 'Dine in'),
  (2, '2022-02-04', 'Dine in'),
  (3, '2022-02-03', 'Take away'),
  (4, '2022-02-07', 'Dine in'),
  (5, '2022-02-08', 'Take away'),
  (6, '2022-02-11', 'Dine in'),
  (7, '2022-02-15', 'Dine in'),
  (8, '2022-02-17', 'Take away'),
  (9, '2022-02-25', 'Dine in'),
  (10,'2022-02-28', 'Take away');

SELECT * FROM orders;

-- TABLE 04 customers
CREATE TABLE customers (
  order_id INT PRIMARY KEY,
  number_of_customer INT,
  customer_type TEXT,
  children boolean
);

INSERT INTO customers values
  (1, 5, 'Friends', FALSE),
  (2, 6, 'Family', TRUE),
  (4, 3, 'Family', TRUE),
  (6, 2, 'Couples', FALSE),
  (7, 1, 'Alone', True),
  (9, 3, 'Friends', FALSE);

SELECT * FROM customers;

-- TABLE 05 food_orders
CREATE TABLE food_orders (
  order_id INT,
  menu_id INT,
  amount REAL
);

INSERT INTO food_orders values
  (1, 1, 5),
  (1, 4, 5),
  (1, 2, 3),
  (1, 9, 2),
  (1, 7, 5),
  (1, 9, 2),
  (1, 10, 1),
  (1, 12, 2),
  (2, 10, 5),
  (2, 12, 7),
  (2, 11, 4),
  (2, 5, 1),
  (2, 9, 4),
  (2, 11, 6),
  (2, 16, 4),
  (2, 7, 2),
  (2, 12, 1),
  (2, 13, 5),
  (2, 12, 3),
  (3, 14, 2),
  (4, 5, 2),
  (4, 6, 2),
  (4, 1, 4),
  (4, 9, 4),
  (5, 7, 6),
  (5, 14, 3),
  (5, 13, 1),
  (5, 12, 2),
  (6, 9, 2),
  (6, 4, 1),
  (6, 3, 4),
  (6, 2, 3),
  (6, 10, 1),
  (7, 5, 4),
  (7, 15, 4),
  (8, 6, 1),
  (8, 7, 7),
  (8, 8, 1),
  (8, 9, 1),
  (8, 12, 2),
  (8, 11, 3),
  (8, 13, 4),
  (8, 4, 5),
  (8, 5, 6),
  (9, 10, 1),
  (9, 7, 2),
  (9, 16, 3),
  (9, 13, 4),
  (9, 10, 7),
  (9, 15, 2),
  (10, 4, 3),
  (10, 5, 3),
  (10, 6, 2),
  (10, 9, 2),
  (10, 10, 2),
  (10, 11, 2),
  (10, 13, 4),
  (10, 14, 2),
  (10, 15, 5);

SELECT * FROM food_orders;

SELECT 
  C.order_id,
  A.menu_detail,
  A.menu_price,
  E.amount,
  A.menu_price*E.amount AS Total
FROM orders C
INNER JOIN food_orders E on C.order_id = E.order_id
INNER JOIN menus A on E.menu_id = A.menu_id;

SELECT 
  C.order_id,
  SUM(A.menu_price*E.amount) AS SUBTotal
FROM orders C
INNER JOIN food_orders E on C.order_id = E.order_id
INNER JOIN menus A on E.menu_id = A.menu_id;

-- ยอดขายทั้งหมด
SELECT 
  order_id,
  SUM(Total) AS income
FROM ( 
SELECT 
  C.order_id,
  A.menu_detail,
  A.menu_price,
  E.amount,
  A.menu_price*E.amount AS Total
FROM orders C
INNER JOIN food_orders E on C.order_id = E.order_id
INNER JOIN menus A on E.menu_id = A.menu_id) AS sub
;

-- Total bill ranking
SELECT 
  order_id,
  order_type,
  COUNT(*) AS no_menu,
  SUM(Total) AS bill_total
FROM ( 
SELECT 
  C.order_id,
  C.order_type,
  A.menu_detail,
  A.menu_price,
  E.amount,
  A.menu_price*E.amount AS Total
FROM orders C
INNER JOIN food_orders E on C.order_id = E.order_id
INNER JOIN menus A on E.menu_id = A.menu_id) AS sub
GROUP BY order_id
ORDER BY bill_total desc;

-- Top 5 order
SELECT 
  menu_detail,
  SUM(amount) AS no_order,
  SUM(Total) AS bill_total
FROM ( 
SELECT 
  C.order_id,
  C.order_type,
  A.menu_detail,
  A.menu_price,
  E.amount,
  A.menu_price*E.amount AS Total
FROM orders C
INNER JOIN food_orders E on C.order_id = E.order_id
INNER JOIN menus A on E.menu_id = A.menu_id) AS sub
GROUP BY menu_detail
ORDER BY bill_total desc
LIMIT 5
;

-- Top 5 Bestseller Main courses
SELECT 
  menu_detail,
  SUM(amount) AS no_order,
  SUM(Total) AS bill_total
FROM ( 
SELECT 
  A.menu_id,
  A.menu_detail,
  B.menu_type,
  A.menu_price,
  E.amount,
  A.menu_price*E.amount AS Total
FROM menus A
INNER JOIN food_orders E on A.menu_id = E.menu_id
INNER JOIN menus_type B on A.menu_id = B.menu_id) AS sub
WHERE menu_type = 'Main courses'
GROUP BY menu_detail
ORDER BY bill_total DESC;

-- AVERAGE Income per bill
SELECT 
  SUM(Total) AS sum_total,
  COUNT(DISTINCT(order_id)) AS no_bill,
  SUM(Total)/COUNT(DISTINCT(order_id)) AS avg_billtotal
FROM ( 
SELECT 
  C.order_id,
  C.order_type,
  A.menu_detail,
  A.menu_price,
  E.amount,
  A.menu_price*E.amount AS Total
FROM orders C
INNER JOIN food_orders E on C.order_id = E.order_id
INNER JOIN menus A on E.menu_id = A.menu_id) AS sub;
