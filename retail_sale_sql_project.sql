-- Retail sale sql project analysis 

-- Drop table if  exists 
DROP TABLE IF EXISTS retail

-- Create table
CREATE TABLE retail_sale(
	transactions_id	INTEGER PRIMARY KEY ,
	sale_date DATE,
	sale_time	TIME,
	customer_id	INTEGER,
	gender	VARCHAR(50),
	age	INTEGER,
	category	VARCHAR(50),
	quantiy	INTEGER,
	price_per_unit	FLOAT,
	cogs	FLOAT,
	total_sale INTEGER

);

-- data explorations and quality checks

-- total row count
SELECT count(*) FROM retail_sale

-- sample data
SELECT * FROM retail_sale 
LIMIT 10;

-- check for null values
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
	
-- delete all null row form retail sale data
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

-- Distinct product categories
SELECT DISTINCT  category FROM retail_sale

-- how many uniques customer we have
SELECT DISTINCT COUNT(customer_id) FROM retail_sale

-- Business queries

-- Q1) write a sql query to retrieve all colums for sales made on '2022-11-05'
SELECT * FROM retail_sale
WHERE sale_date = '2022-11-05'

-- Q2) write a sql query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 10 in the month of NOV-2022
 
SELECT * FROM retail_sale
WHERE category = 'clothing'
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
AND quantiy>3;

-- Q3) write a sql query to calculate the total sales for each category
SELECT category,SUM(total_sale) AS total_sale_each_category FROM retail_sale
GROUP BY category
ORDER BY total_sale_each_category DESC;

-- Q4) write a sql query to find the average age of customers who purchased items from the 'beauty' category
SELECT category, ROUND(AVG(age),2) FROM retail_sale
WHERE category = 'Beauty'
GROUP BY category;

-- Q5) write a sql query to find all transactions where the total_sale is greater than 1000.
SELECT transactions_id, total_sale FROM retail_sale
WHERE total_sale>1000
ORDER BY total_sale;

--Q6) write a sql query to find the number of transactions(transaction_id) made by each gender in each category.
SELECT category, gender, COUNT(transactions_id) AS total_transactions_id
FROM retail_sale
GROUP BY category, gender
ORDER BY category,gender;

--Q7) write a sql query to calculate the average sale for each month , find out best selling month in year:
SELECT * FROM
(
	SELECT EXTRACT(YEAR FROM sale_date) AS year, EXTRACT(MONTH FROM sale_date) AS month,
	AVG(total_sale) AS average_sale_each_month ,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC)
	FROM retail_sale
	GROUP BY 1,2
	ORDER BY 1,2
) AS t1
WHERE RANK =1

-- Q8) write a sql query to find the top 5 customers based on the highest total sales
SELECT customer_id, SUM(total_sale) AS total_sales 
FROM retail_sale
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q9) write a sql query to find the number of unique customers who purchased items from each category 
SELECT category,
	   COUNT(DISTINCT customer_id) AS unique_customer
	   FROM retail_sale
GROUP BY category









