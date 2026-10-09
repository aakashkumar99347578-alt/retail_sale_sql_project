# Retail Sales Analysis SQL Project

## Project Overview
This project involves setting up a retail sales database, performing data exploration and data cleaning, and executing business analysis queries using SQL.

---

## Database & Table Schema

The database table `retail_sale` stores transaction details:

```sql
CREATE TABLE retail_sale (
    transactions_id INTEGER PRIMARY KEY,
    sale_date       DATE,
    sale_time       TIME,
    customer_id     INTEGER,
    gender          VARCHAR(50),
    age             INTEGER,
    category        VARCHAR(50),
    quantiy         INTEGER,
    price_per_unit  FLOAT,
    cogs            FLOAT,
    total_sale      INTEGER
);
```

---

## Data Exploration & Data Cleaning

### 1. Total Row Count
```sql
SELECT COUNT(*) FROM retail_sale;
```

### 2. Sample Data Inspection
```sql
SELECT * FROM retail_sale 
LIMIT 10;
```

### 3. Check for NULL Values
```sql
SELECT * FROM retail_sale
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

### 4. Delete Rows with NULL Values
```sql
DELETE FROM retail_sale
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

### 5. Distinct Product Categories
```sql
SELECT DISTINCT category FROM retail_sale;
```

### 6. Count of Unique Customers
```sql
SELECT DISTINCT COUNT(customer_id) FROM retail_sale;
```

---

## Business Analysis Queries

### Q1: Retrieve all columns for sales made on '2022-11-05'
```sql
SELECT * FROM retail_sale
WHERE sale_date = '2022-11-05';
```

### Q2: Retrieve transactions for 'Clothing' category with quantity sold > 3 in November 2022
```sql
SELECT * FROM retail_sale
WHERE category = 'clothing'
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
  AND quantiy > 3;
```

### Q3: Calculate the total sales for each category
```sql
SELECT category, SUM(total_sale) AS total_sale_each_category 
FROM retail_sale
GROUP BY category
ORDER BY total_sale_each_category DESC;
```

### Q4: Find the average age of customers who purchased items from the 'Beauty' category
```sql
SELECT category, ROUND(AVG(age), 2) 
FROM retail_sale
WHERE category = 'Beauty'
GROUP BY category;
```

### Q5: Find all transactions where total_sale is greater than 1000
```sql
SELECT transactions_id, total_sale 
FROM retail_sale
WHERE total_sale > 1000
ORDER BY total_sale;
```

### Q6: Find the number of transactions made by each gender in each category
```sql
SELECT category, gender, COUNT(transactions_id) AS total_transactions_id
FROM retail_sale
GROUP BY category, gender
ORDER BY category, gender;
```

### Q7: Calculate the average sale for each month and find the best-selling month per year
```sql
SELECT * FROM
(
    SELECT EXTRACT(YEAR FROM sale_date) AS year, 
           EXTRACT(MONTH FROM sale_date) AS month,
           AVG(total_sale) AS average_sale_each_month,
           RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sale
    GROUP BY 1, 2
    ORDER BY 1, 2
) AS t1
WHERE rank = 1;
```

### Q8: Find the top 5 customers based on the highest total sales
```sql
SELECT customer_id, SUM(total_sale) AS total_sales 
FROM retail_sale
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

### Q9: Find the number of unique customers who purchased items from each category
```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customer
FROM retail_sale
GROUP BY category;
```

---

## Project Files
- `retail_sale_sql_project.sql`: SQL script containing schema creation, cleaning operations, and analysis queries.
- `SQL - Retail Sales Analysis_utf .csv`: Dataset containing retail sales transactions.
