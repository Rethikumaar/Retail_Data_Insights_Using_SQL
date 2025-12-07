# 1\. 🛍️ Retail Sales Data Analysis with SQL

## 2\. Executive Summary

This project demonstrates an end-to-end retail sales data analysis lifecycle using **SQL**. The scope includes database setup, rigorous data cleaning, and advanced analysis using **10 key SQL queries**. The findings provide valuable insights into customer purchasing habits, sales performance by category, and operational trends.

-----

## 3\. Business Problem

The objective is to leverage raw retail sales transaction data to answer critical business questions, thereby providing the foundation for strategic decisions. The key areas of inquiry are:

  * **Performance Tracking:** Understanding total sales, order volume, and category profitability.
  * **Customer Segmentation:** Identifying High-Value Customers (HVCs) and analyzing purchasing demographics.
  * **Operational Optimization:** Pinpointing peak sales periods (monthly and hourly) to inform staffing and inventory strategies.

-----

## 4\. Methodology

The analysis followed a structured, three-phase approach: Database Setup, Data Cleaning & EDA, and Business Query Execution.

### 4.1. Database Setup

The `p1_retail_db` database and the `retail_sales` table were created to host the transactional data.

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

### 4.2. Data Exploration & Cleaning

Data quality was ensured by checking core metrics and handling missing values.

  * **Core Metrics:** Total Records (`COUNT(*)`), Unique Customers (`COUNT(DISTINCT customer_id)`), and Unique Categories (`DISTINCT category`).
  * **Data Cleaning:** Records containing any `NULL` values in critical fields were identified and deleted to maintain data integrity for accurate aggregation.

<!-- end list -->

```sql
-- Identify NULL Records
SELECT * FROM retail_sales WHERE /* ... WHERE conditions for NULL ... */ ;

-- Delete NULL Records
DELETE FROM retail_sales WHERE /* ... WHERE conditions for NULL ... */ ;
```

### 4.3. Business Query Execution (The 10 Analytical Solutions)

Advanced SQL queries were developed to extract specific business insights.

| Query | Objective | Key SQL Technique |
| :--- | :--- | :--- |
| **Q1** | Sales on '2022-11-05' | Basic Filtering (`WHERE`) |
| **Q3** | Total Sales & Order Count per Category | Aggregation (`SUM`, `COUNT`), `GROUP BY` |
| **Q7** | Best-selling Month per Year | **Window Function** (`RANK()`), Subquery |
| **Q8** | Top 5 Customers by Spending | Aggregation (`SUM`), Ordering (`DESC`), `LIMIT` |
| **Q10** | Orders by Time-of-Day Shift | **Common Table Expression (CTE)**, `CASE` Statement |

-----

## 5\. Skills

💻 SQL & Data Analysis Skills Demonstrated
SQL Mastery: Expert use of CREATE, DELETE, GROUP BY, SUM, AVG, and COUNT(DISTINCT) for data definition, manipulation, and fundamental aggregation.

Advanced SQL Techniques: Proficient application of Window Functions (e.g., RANK()), Common Table Expressions (CTEs), and Subqueries for complex, multi-step calculations.

Data Manipulation: Effective use of conditional logic (CASE statement) and date/time functions (DATE_FORMAT, YEAR, MONTH, HOUR) for time-based segmentation and filtering.

Problem Solving: Ability to translate abstract business questions into precise, executable SQL logic.
-----

## 6\. Results & Business Recommendations

The executed SQL queries yielded critical insights, forming the basis for the following business recommendations:

### Key Insights

| Finding | Source Query | Insight |
| :--- | :--- | :--- |
| **High-Value Segments** | Q3, Q9 | **Clothing** and **Beauty** are the strongest categories, both in terms of revenue and unique customer engagement. |
| **Customer Loyalty** | Q8 | A small group of **Top 5 Customers** drives a disproportionate amount of revenue, indicating successful **High-Value Customer (HVC)** identification. |
| **Peak Operational Period** | Q10 | **Evening hours** consistently record the highest order activity. |
| **Seasonal Trends** | Q7 | Clear **high-performing months** were identified (based on average sale), which should dictate seasonal budget allocation. |

### Business Recommendations

1.  **HVC Program:** Implement a dedicated loyalty and retention program targeting the identified **Top 5 customers** to maximize lifetime value.
2.  **Operational Strategy:** Optimize staffing and inventory replenishment schedules to align with the **Evening peak demand** identified in the time-shift analysis.
3.  **Targeted Marketing:** Use the average age derived for the 'Beauty' category (Q4) to refine demographic targeting for future marketing campaigns in that segment.
4.  **Inventory Focus:** Prioritize inventory investment in the highest-performing categories, **Clothing** and **Beauty**, based on their net sales and order count.

-----

## 7\. Next Steps

This project can be expanded into a more robust data engineering solution:

1.  **Visualization Layer:** Connect the `p1_retail_db` to a business intelligence tool (e.g., Tableau, Power BI) to create interactive dashboards based on the derived SQL results.
2.  **RFM Analysis:** Extend the customer spending analysis (Q8) into a full **Recency, Frequency, Monetary (RFM)** model to create more granular customer segments.
3.  **Profit Analysis:** Calculate Gross Margin for each category using the $\text{COGS}$ and $\text{total\_sale}$ columns to shift focus from gross sales to true profitability.

-----

### Author

**P. Rethi Kumaar**
Information Science Engineering | CGPA: 7.8
Aspiring Data Analyst & Developer

| Platform | Link |
| :--- | :--- |
| **GitHub** | [https://github.com/JackieRK](https://github.com/Rethikumaar) |
| **LinkedIn** | [https://linkedin.com/in/rethi-kumaar](https://linkedin.com/in/rethi-kumaar) |
