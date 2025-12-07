-- create DB
create database sql_query_p1;

-- use the DB
use sql_query_p1;

-- create a table
CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

select * from retail_sales
limit 10;

select count(*) from retail_sales;

select * from retail_sales;

-- Data Cleaning
SELECT * FROM retail_sales
WHERE
transactions_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
gender IS NULL
OR
category IS NULL
OR
quantity IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

-- delete the null records 
SET SQL_SAFE_UPDATES = 0;

DELETE FROM retail_sales
WHERE
    transactions_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR gender IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;

-- SET SQL_SAFE_UPDATES = 1;  -- (optional)

-- Data Exploration
-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales;
-- How many uniuque customers we have ?
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;

SELECT DISTINCT category FROM retail_sales;

-- Data Analysis & Findings

/* 1. Retrieve all columns for sales made on '2022-11-05' */
-- Filtering all records where sale_date matches the given date
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';



/* 2. Retrieve transactions where category = 'Clothing' AND quantity > 4 in Nov-2022 */
-- Using DATE_FORMAT to extract 'YYYY-MM' for month filtering
SELECT 
    *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
    AND quantity > 4;



/* 3. Calculate the total sales (total_sale) for each category */
-- SUM gives total revenue and COUNT gives number of orders
SELECT 
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;



/* 4. Find the average age of customers who purchased from the 'Beauty' category */
-- AVG(age) calculates mean age, rounded to 2 decimals
SELECT
    ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';



/* 5. Retrieve all transactions where total_sale > 1000 */
-- Simple filter for high-value transactions
SELECT *
FROM retail_sales
WHERE total_sale > 1000;



/* 6. Find total number of transactions by each gender in each category */
-- Grouping by category and gender to count how many transactions occurred
SELECT 
    category,
    gender,
    COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;



/* 7. Find the best-selling month in each year based on average total sale */
-- Ranking months within each year using window functions
SELECT 
    year,
    month,
    avg_sale
FROM 
(
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rnk
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS t1
WHERE rnk = 1;   -- Selecting top month of each year



/* 8. Find the top 5 customers based on highest total sales */
-- Summing sales per customer and ordering from highest to lowest
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;



/* 9. Find the number of unique customers who purchased from each category */
-- COUNT(DISTINCT) ensures customers are not double-counted
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM retail_sales
GROUP BY category;



/* 10. Create shifts (Morning, Afternoon, Evening) and count orders in each shift */
-- Using CASE to categorize hours into time shifts
WITH hourly_sale AS
(
    SELECT *,
        CASE
            WHEN HOUR(sale_time) < 12 THEN 'Morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;



