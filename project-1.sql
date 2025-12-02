--SQL Retail Sales Analysis- P1

--Create Table--

Create Table retail_Sales
(
transactions_id	INT PRIMARY KEY,
sale_date  DATE,
sale_time TIME,	
customer_id INT,
gender VARCHAR (50),	
age	INT,
category VARCHAR (50),
quantiy	INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
)


alter table retail_Sales
rename column quantiy to quantity



--DATA CLEANING -

SELECT * FROM RETAIL_SALES
WHERE transactions_id is null
or
sale_date is null
or customer_id is null
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs is null
or total_sale is null


delete FROM RETAIL_SALES
WHERE transactions_id is null
or
sale_date is null
or customer_id is null
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs is null
or total_sale is null

select * from retail_sales

--DATA EXPLORATIONS -

-- How many sales we have?

select count(*) from retail_Sales

-- how many unique customers we have?

select count(distinct(customer_id)) as customers from retail_Sales

-- how many categories we have?

select distinct(category) as customers from retail_Sales

-- Data Analysis & Business key problems and solutions

--1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:

	select * from retail_sales 
	where sale_date = '2022-11-05'

--2.Write a SQL query to retrieve all transactions 
--where the category is 'Clothing' and the quantity sold is more than 2
--in the month of Nov-2022:

	select * from retail_sales
	where category = 'Clothing'
	AND quantity > 2
	AND EXTRACT('MONTH' FROM sale_date) = 11
	AND EXTRACT('year' FROM sale_date) = 2022

--3.Write a SQL query to calculate the total sales (total_sale) for each category.

	select category, sum(total_Sale) as total_Sales from retail_sales
	group by category

--4.Write a SQL query to find the average age of customers 
--who purchased items from the 'Beauty' category.:

	select category, avg(age) as avg_age from retail_Sales
	where category = 'Beauty'
	group by category

--5.Write a SQL query to find all transactions 
--where the total_sale is greater than 1000

	select * from retail_Sales
	where total_Sale > 1000

--6.Write a SQL query to find the total number of transactions (transactions_id) 
--made by each gender in each category.:

	select gender,category,count(transactions_id) as total_transactions
	from retail_Sales
	group by gender,category order by category

--7.Write a SQL query to calculate the average sale for each month. 
--Find out best selling month in each year:

	select x.* from
	(select extract('month' from sale_date) as month,
	extract(year from sale_date) as year,
	avg(total_Sale) as avg_sales,
	rank() over(Partition by  extract(year from sale_date) order by avg(total_Sale) desc ) as rnk
	from retail_Sales
	group by month,year) as x
	where rnk = 1

--8.Write a SQL query to find the top 5 customers based on the 
--highest total sales 

   select customer_id, sum(total_Sale) as total_sales from retail_Sales
   group by customer_id order by total_sales desc limit 5

--9.Write a SQL query to find the number of unique customers 
--who purchased items from each category

	select count(distinct(customer_id)) as unique_customer, category
	from retail_Sales
	group by category

--10.Write a SQL query to create each shift and number of orders
--(Example Morning <12, Afternoon Between 12 & 17, Evening >17):

	SELECT count(transactions_id) as total_orders,
	CASE
	WHEN EXTRACT(HOUR FROM SALE_TIME) < 12 THEN 'Morning'
	WHEN EXTRACT(HOUR FROM SALE_TIME) between 12 and 17 THEN 'Afternoon'
	else 'Evening'
	end as shift
	FROM RETAIL_SALES
	group by shift 

-- End Of Project--




