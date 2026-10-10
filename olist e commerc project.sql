create database olist;
use olist;
SELECT COUNT(*) FROM olist.olist_orders_dataset;
USE olist;

CREATE TABLE orders(
  customer_id VARCHAR(50),
  customer_unique_id VARCHAR(50),
  customer_zip_code_prefix VARCHAR(10),
  customer_city VARCHAR(100),
  customer_state VARCHAR(5)
);

LOAD DATA INFILE 'C:\Users\ThinkPad\Downloads\archive (1)\olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, @state)
SET customer_state = TRIM(TRAILING '\r' FROM @state;
SHOW VARIABLES LIKE 'secure_file_priv';


USE olist;

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
  customer_id VARCHAR(50),
  customer_unique_id VARCHAR(50),
  customer_zip_code_prefix VARCHAR(10),
  customer_city VARCHAR(100),
  customer_state VARCHAR(5)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, @state)
SET customer_state = TRIM(TRAILING '\r' FROM @state);

SELECT COUNT(*) FROM olist_customers_dataset;

USE olist;

DROP TABLE IF EXISTS olist_customers_dataset;

CREATE TABLE olist_customers_dataset (
  customer_id VARCHAR(50),
  customer_unique_id VARCHAR(50),
  customer_zip_code_prefix VARCHAR(10),
  customer_city VARCHAR(100),
  customer_state VARCHAR(5)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_customers_dataset.csv'
INTO TABLE olist_customers_dataset
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, @state)
SET customer_state = TRIM(TRAILING '\r' FROM @state);

SELECT COUNT(*) FROM olist_customers_dataset;
USE olist;
SHOW TABLES;
#Count how many orders there are for each order_status.
select*from olist_orders_dataset;
select order_status,count(*) from olist_orders_dataset group by order_status order by count(*)desc;

#Top 10 customer states by number of orders
select * from olist_customers_dataset;

#Load the next 3 tables (

DROP TABLE IF EXISTS olist_order_items_dataset;
CREATE TABLE olist_order_items_dataset (
  order_id VARCHAR(50),
  order_item_id INT,
  product_id VARCHAR(50),
  seller_id VARCHAR(50),
  shipping_limit_date VARCHAR(30),
  price DECIMAL(10,2),
  freight_value DECIMAL(10,2)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_items_dataset.csv'
INTO TABLE olist_order_items_dataset
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, @freight)
SET freight_value = TRIM(TRAILING '\r' FROM @freight);

DROP TABLE IF EXISTS olist_products_dataset;
CREATE TABLE olist_products_dataset (
  product_id VARCHAR(50),
  product_category_name VARCHAR(100),
  product_name_length VARCHAR(20),
  product_description_length VARCHAR(20),
  product_photos_qty VARCHAR(20),
  product_weight_g VARCHAR(20),
  product_length_cm VARCHAR(20),
  product_height_cm VARCHAR(20),
  product_width_cm VARCHAR(20)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_products_dataset.csv'
INTO TABLE olist_products_dataset
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS product_category_name_translation;
CREATE TABLE product_category_name_translation (
  product_category_name VARCHAR(100),
  product_category_name_english VARCHAR(100)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product_category_name_translation.csv'
INTO TABLE product_category_name_translation
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(product_category_name, @english)
SET product_category_name_english = TRIM(TRAILING '\r' FROM @english);

SELECT 'items' AS tbl, COUNT(*) FROM olist_order_items_dataset
UNION ALL SELECT 'products', COUNT(*) FROM olist_products_dataset
UNION ALL SELECT 'translation', COUNT(*) FROM product_category_name_translation;
SELECT COUNT(*) FROM olist_order_items_dataset;

#Top 10 product categories by total revenue (English names)
show tables;
select * from olist_order_items_dataset;
select* from product_category_name_translation;
select* from olist_products_dataset;
SELECT t.product_category_name_english, SUM(i.price) AS total_revenue
FROM olist_order_items_dataset i
JOIN olist_products_dataset p
  ON i.product_id = p.product_id
JOIN product_category_name_translation t
  ON p.product_category_name= t.product_category_name
GROUP BY t.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;



DROP TABLE IF EXISTS olist_order_reviews_dataset;
CREATE TABLE olist_order_reviews_dataset (
  review_id VARCHAR(50),
  order_id VARCHAR(50),
  review_score INT,
  review_comment_title TEXT,
  review_comment_message TEXT,
  review_creation_date VARCHAR(100),
  review_answer_timestamp VARCHAR(30)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_reviews_dataset.csv'
INTO TABLE olist_order_reviews_dataset
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(review_id, order_id, review_score, review_comment_title, review_comment_message, review_creation_date, @answer)
SET review_answer_timestamp = TRIM(TRAILING '\r' FROM @answer);

DROP TABLE IF EXISTS olist_sellers_dataset;
CREATE TABLE olist_sellers_dataset (
  seller_id VARCHAR(50),
  seller_zip_code_prefix VARCHAR(10),
  seller_city VARCHAR(100),
  seller_state VARCHAR(5)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_sellers_dataset.csv'
INTO TABLE olist_sellers_dataset
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(seller_id, seller_zip_code_prefix, seller_city, @state)
SET seller_state = TRIM(TRAILING '\r' FROM @state);

SELECT 'reviews' AS tbl, COUNT(*) FROM olist_order_reviews_dataset
UNION ALL SELECT 'sellers', COUNT(*) FROM olist_sellers_dataset
UNION ALL SELECT 'items', COUNT(*) FROM olist_order_items_dataset;

USE olist;
SET SESSION sql_mode = '';

DROP TABLE IF EXISTS olist_order_reviews_dataset;
CREATE TABLE olist_order_reviews_dataset (
  review_id VARCHAR(50),
  order_id VARCHAR(50),
  review_score INT,
  review_comment_title TEXT,
  review_comment_message TEXT,
  review_creation_date VARCHAR(30),
  review_answer_timestamp VARCHAR(30)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_reviews_dataset.csv'
INTO TABLE olist_order_reviews_dataset
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(review_id, order_id, review_score, review_comment_title, review_comment_message, review_creation_date, @answer)
SET review_answer_timestamp = TRIM(TRAILING '\r' FROM @answer);

SELECT COUNT(*) FROM olist_order_reviews_dataset;

USE olist;

DROP TABLE IF EXISTS olist_sellers_dataset;
CREATE TABLE olist_sellers_dataset (
  seller_id VARCHAR(50),
  seller_zip_code_prefix VARCHAR(10),
  seller_city VARCHAR(100),
  seller_state VARCHAR(5)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_sellers_dataset.csv'
INTO TABLE olist_sellers_dataset
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(seller_id, seller_zip_code_prefix, seller_city, @state)
SET seller_state = TRIM(TRAILING '\r' FROM @state);

SELECT 'reviews' AS tbl, COUNT(*) AS row_count FROM olist_order_reviews_dataset
UNION ALL SELECT 'sellers', COUNT(*) FROM olist_sellers_dataset
UNION ALL SELECT 'items', COUNT(*) FROM olist_order_items_dataset
UNION ALL SELECT 'products', COUNT(*) FROM olist_products_dataset
UNION ALL SELECT 'translation', COUNT(*) FROM product_category_name_translation;

#Average review score per category (only categories with 100+ reviews)
show tables;
select* from olist_order_reviews_dataset;
select* from olist_order_items_dataset;
SELECT t.product_category_name_english,
       AVG(r.review_score) AS avg_score,
       COUNT(*) AS total_reviews
FROM olist_order_reviews_dataset r
JOIN olist_order_items_dataset i
  ON r.order_id= i.order_id
JOIN olist_products_dataset p
  ON i.product_id = p.product_id
JOIN product_category_name_translation t
  ON p.product_category_name = t.product_category_name
GROUP BY t.product_category_name_english
HAVING COUNT(*) >= 100
ORDER BY avg_score DESC;


USE olist;

SELECT COUNT(*) AS delivered_orders
FROM olist_orders_dataset
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_delivered_customer_date <> '';
  
  
  SELECT order_id,
       order_delivered_customer_date,
       order_estimated_delivery_date
FROM olist_orders_dataset
WHERE order_status = 'delivered'
LIMIT 10;
USE olist;

SELECT order_id,
       order_delivered_customer_date,
       order_estimated_delivery_date,
       CASE WHEN order_delivered_customer_date>order_estimated_delivery_date THEN 1 ELSE 0 END AS is_late
FROM olist_orders_dataset
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_delivered_customer_date <> ''
LIMIT 20;

USE olist;

SELECT COUNT(*) AS delivered_orders,
       SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 ELSE 0 END) AS late_orders,
       ROUND(100.0 * SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 ELSE 0 END) / COUNT(*), 2) AS late_pct
FROM olist_orders_dataset
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_delivered_customer_date <> '';
  
  #Top 10 sellers by revenue, with their state
  select* from olist_sellers_dataset ;

SELECT s.seller_id,
       s.seller_state,
       ROUND(SUM(i.price), 2) AS total_revenue
FROM olist_order_items_dataset i
JOIN olist_sellers_dataset s
  ON i.seller_id = s.seller_id
GROUP BY s.seller_id, s.seller_state
ORDER BY total_revenue desc
LIMIT 10;

#: Top 3 sellers in each state
WITH seller_rev AS (
  SELECT s.seller_id,
         s.seller_state,
         SUM(i.price) AS revenue
  FROM olist_order_items_dataset i
  JOIN olist_sellers_dataset s
    ON i.seller_id = s.seller_id
  GROUP BY s.seller_id, s.seller_state
),
ranked AS (
  SELECT seller_id,
         seller_state,
         ROUND(revenue, 2) AS revenue,
         RANK() OVER (PARTITION BY seller_state ORDER BY revenue DESC) AS rnk
  FROM seller_rev
)
SELECT *
FROM ranked
WHERE rnk <= 3
ORDER BY seller_state, rnk;

#: Monthly revenue and month-over-month growth
USE olist;

WITH monthly AS (
  SELECT LEFT(o.order_purchase_timestamp, 7) AS order_month,
         ROUND(SUM(i.price), 2) AS revenue
  FROM olist_orders_dataset o
  JOIN olist_order_items_dataset i
    ON o.order_id = i.order_id
  WHERE o.order_status = 'delivered'
  GROUP BY LEFT(o.order_purchase_timestamp, 7)
)
SELECT order_month,
       revenue,
       LAG(revenue) OVER (ORDER BY order_month) AS prev_revenue,
       ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY order_month))
             / LAG(revenue) OVER (ORDER BY order_month), 2) AS mom_growth_pct
FROM monthly
ORDER BY order_month;

#Review score, late vs on-time


SELECT CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
            THEN 'Late' ELSE 'On time' END AS delivery_status,
       COUNT(*) AS total_reviews,
       ROUND(AVG(r.review_score), 2) AS avg_score
FROM olist_orders_dataset o
JOIN olist_order_reviews_dataset r
  ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_delivered_customer_date <> ''
GROUP BY delivery_status;

#: High-value but risky sellers
WITH seller_order AS (
  SELECT i.seller_id,
         i.order_id,
         SUM(i.price) AS order_revenue,
         MAX(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
                  THEN 1 ELSE 0 END) AS is_late
  FROM olist_order_items_dataset i
  JOIN olist_orders_dataset o
    ON i.order_id = o.order_id
  WHERE o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
    AND o.order_delivered_customer_date <> ''
  GROUP BY i.seller_id, i.order_id
),
seller_stats AS (
  SELECT seller_id,
         COUNT(*) AS total_orders,
         ROUND(SUM(order_revenue), 2) AS revenue,
         ROUND(100.0 * SUM(is_late) / COUNT(*), 2) AS late_pct
  FROM seller_order
  GROUP BY seller_id
)
SELECT *
FROM seller_stats
WHERE total_orders >= 30
  AND late_pct > 10
  AND revenue > (SELECT AVG(revenue) FROM seller_stats)
ORDER BY revenue DESC;