-- create database pizza;
-- use pizza;
-- CREATE TABLE pizza_sales (
--     pizza_id INT,
--     order_id INT,
--     pizza_name_id VARCHAR(50),
--     quantity INT,
--     order_date DATE,
--     order_time TIME,
--     unit_price DECIMAL(6,2),
--     total_price DECIMAL(6,2),
--     pizza_size CHAR(1),
--     pizza_category VARCHAR(20),
--     pizza_ingredients TEXT,
--     pizza_name VARCHAR(100)
-- );

-- LOAD DATA INFILE
-- 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/pizza_sales.csv'
-- INTO TABLE pizza_sales
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- ESCAPED BY '"'
-- LINES TERMINATED BY '\r\n'
-- IGNORE 1 ROWS
-- (
-- pizza_id,
-- order_id,
-- pizza_name_id,
-- quantity,
-- @order_date,
-- order_time,
-- unit_price,
-- total_price,
-- pizza_size,
-- pizza_category,
-- pizza_ingredients,
-- pizza_name
-- )
-- SET order_date = STR_TO_DATE(@order_date, '%d-%m-%Y');

select * from pizza_sales;

--  1. TOTAL REVENUE
-- select sum(total_price) as Total_Revenue
-- from pizza_sales

-- 2. Average Order Value
-- select  sum(total_price) /count( distinct order_id) as "Average Order Value"
-- from pizza_sales

-- 3. Total Pizza's Sold

select Sum(quantity) as "Total Pizza's Sold"
from Pizza_sales;

-- 4. Total Orders 
select  count(distinct Order_id) as "Total Orders" 
from pizza_sales;

-- 5. Average Pizza  sold Per order
select Sum(quantity) /count(distinct Order_id) as " "
from Pizza_sales;

-- 6.Daily Trend for total orders
SELECT dayname(order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY dayname(order_date);

-- 7.Hourly  Trend for total orders
SELECT hour(order_time) AS order_hour, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY hour(order_time);


select pizza_category ,sum(total_price) as Total_revenue, round((sum(total_price)/(select Sum(total_price) from pizza_sales where month(order_date) =1))*100,2) as "Percentage" 
from pizza_sales
where month(order_date) =1
group by pizza_category;

select pizza_size , sum(total_price)/(select sum(total_price) FROM Pizza_sales)*100  as "Percentage By Size"
from pizza_sales
group by pizza_size;

select pizza_category , sum(quantity) as Quantity_Sold
from pizza_sales
group by pizza_category ;


select pizza_name ,Sum(quantity) as "Total Pizza's Sold"
from pizza_sales 
group by pizza_Name
order by Sum(quantity) ASC
limit 5;


SELECT 
    DAYNAME(order_date) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
WHERE QUARTER(order_date) = 1
GROUP BY DAYNAME(order_date);


-- MOnthly Trend for orders
select monthname(order_date) as Month, count( distinct order_id) as total_orders
from pizza_sales
group by monthname(order_date),month(order_date)
order by month(order_date);


-- top 5 pizza by revenue

select pizza_name , sum(total_price) as Revenue
from pizza_sales 
group by pizza_name
order by Revenue desc
limit 5;


-- bottom 5 pizzas by revenue
select pizza_name , sum(total_price) as Revenue
from pizza_sales 
group by pizza_name
order by Revenue Asc
limit 5;

-- top 5 pizzaas by total orders

select pizza_name , count(distinct order_Id) as Orders
from pizza_sales 
group by  pizza_name
order by Orders desc
limit 5;

-- bootom 5 pizza by total orders
select pizza_name , count(distinct order_Id) as Orders
from pizza_sales 
group by  pizza_name
order by Orders asc
limit 5;


























































