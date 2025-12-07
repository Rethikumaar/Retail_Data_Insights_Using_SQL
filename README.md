-----

# 1\. 🛍️ Retail Data Insights using SQL

## 2\. Project Overview

This project demonstrates a complete retail sales data analysis lifecycle using **SQL**. It covers setting up a database, essential data cleaning, exploratory data analysis (EDA), and addressing **10 key business questions** to derive valuable insights into sales performance, customer behavior, and purchasing trends.

**Database:** `p1_retail_db`

**Key Skills Demonstrated:** SQL (Database Setup, Data Cleaning, Aggregation, Window Functions, Subqueries), Exploratory Data Analysis (EDA).

-----

## 3\. Project Objectives

1.  **Database Structure:** Create and define the schema for a retail sales SQL database.
2.  **Data Quality:** Clean and validate raw data to ensure accuracy for analysis.
3.  **Exploratory Analysis:** Perform initial data exploration using foundational SQL queries.
4.  **Business Intelligence:** Answer 10 critical business questions using advanced SQL techniques.
5.  **Insight Generation:** Identify trends in customer behavior, sales performance, and high-performing periods.

-----

# 4\. ⚙️ Database Setup & Schema

## 4.1. Database and Table Creation

The `p1_retail_db` database and the `retail_sales` table were created with the following schema:

```sql
CREATE DATABASE p1_retail_db;

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
```

-----

# 5\. 🧹 Data Exploration & Cleaning

Initial checks were performed to understand the data volume, unique identifiers, and data quality before running core analysis queries.

## 5.1. Total Records Count

```sql
SELECT COUNT(*) FROM retail_sales;
```

## 5.2. Unique Customers Count

```sql
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
```

## 5.3. Unique Product Categories

```sql
SELECT DISTINCT category FROM retail_sales;
```

## 5.4. Identifying and Deleting NULL Records

Handling missing data is a crucial step for accurate analysis.

  * **Identify NULL Records:**

    ```sql
    SELECT *
    FROM retail_sales
    WHERE 
        sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR
        gender IS NULL OR age IS NULL OR category IS NULL OR
        quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
    ```

  * **Delete NULL Records:**

    ```sql
    DELETE FROM retail_sales
    WHERE 
        sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR
        gender IS NULL OR age IS NULL OR category IS NULL OR
        quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
    ```

-----

# 6\. 📊 Business Analysis — SQL Queries

The following 10 queries were executed to answer specific business questions and generate actionable insights.

## 6.1. Query 1: Retrieve all sales made on '2022-11-05'

```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

## 6.2. Query 2: Clothing transactions with quantity \> 4 in Nov 2022

```sql
SELECT *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
    AND quantity > 4;
```

## 6.3. Query 3: Total sales & order count per category

```sql
SELECT 
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

## 6.4. Query 4: Average age of 'Beauty' product customers

```sql
SELECT 
    ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

## 6.5. Query 5: Transactions where total\_sale \> 1000

```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

## 6.6. Query 6: Total transactions by gender for each category

```sql
SELECT 
    category,
    gender,
    COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
```

## 6.7. Query 7: Best-selling month of each year (highest average sale)

This query utilizes a **Window Function (`RANK()`)** within a Subquery to identify the highest average sales month per year.

```sql
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
WHERE rnk = 1;
```

## 6.8. Query 8: Top 5 customers by total spending

This is a key query for identifying **High-Value Customers (HVCs)**.

```sql
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

## 6.9. Query 9: Unique customer count for each category

This shows customer engagement across different product lines.

```sql
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM retail_sales
GROUP BY category;
```

## 6.10. Query 10: Create shift categories & count orders

This query uses a **Common Table Expression (CTE)** and a `CASE` statement to categorize orders by time of day (Morning, Afternoon, Evening) for operational insights.

```sql
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
```

-----

# 7\. 🔑 Key Insights & Business Recommendations

Based on the SQL analysis, the following insights were generated:

  * **Category Performance:** **Clothing** and **Beauty** categories show strong sales performance and high unique customer engagement, suggesting they are core revenue drivers.
  * **Customer Segmentation (HVCs):** A small group of **Top 5 customers** significantly impacts overall revenue, highlighting an opportunity for a targeted loyalty program.
  * **Operational Trends:** **Evening hours** record the highest order activity, indicating peak demand periods for staffing or marketing efforts.
  * **Seasonal Trends:** The analysis of average sales by month identified **high-performing months**, which should be leveraged for inventory planning and seasonal promotions.
  * **Demographic Focus:** The average age of customers for product categories like 'Beauty' provides a target demographic for future marketing campaigns.

-----

# 8\. 📝 Conclusion

This project successfully demonstrates the capability to perform an end-to-end data analysis workflow, which is a core skill for a Data Analyst role.

**Key Achievements:**

  * Proficiency in **SQL database creation** and schema definition.
  * Successful application of **data cleaning and preprocessing** techniques.
  * Expert use of SQL features including **Aggregations, Subqueries, and Window Functions**.
  * Ability to translate **real-world business questions** into analytical solutions.
  * Delivering **actionable business insights** for trend identification and performance optimization.

-----

# 9\. 🧑‍💻 Author

**P. Rethi Kumaar**
Information Science Engineering | CGPA: 7.8
Aspiring Data Analyst & Developer

| Platform | Link |
| :--- | :--- |
| **GitHub** | [https://github.com/JackieRK](https://github.com/JackieRK) |
| **LinkedIn** | [https://linkedin.com/in/rethi-kumaar](https://linkedin.com/in/rethi-kumaar) |

-----
