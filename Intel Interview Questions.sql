drop table if exists reviews
create table reviews
(review_id int not null,
user_id int not null,
submit_date date not null,
product_id int not null,
stars dec(1,0) not null)

insert into reviews
values
(6171,123,'06/08/2022',50001,4),
(7802,265,'06/10/2022',69852,4),
(5293,362,'06/18/2022',50001,3),
(6352,192,'07/26/2022',69852,3),
(4517,981,'07/05/2022',69852,2)

select *
from reviews


/**Question 1: Compute Average Product Review Ratings Per Month
Intel is interested in evaluating the performance of its products 
based on user reviews. Given the reviews table that contains a 
product's ID, the date the review was submitted, and a user's given 
star rating (1 through 5), write a SQL query to compute the average 
star rating for each product per month.**/

select product_id,
ceiling(avg(stars)) avg_star_rating,
cast(month(submit_date) as int) as [month]
from reviews
group by product_id,cast(month(submit_date) as int)

select product_id, ceiling(avg(stars)) as avg_rating,
cast(month(submit_date) as int) as [month]
from reviews
group by product_id,cast(month(submit_date) as int)

select cast(month(submit_date) as int) as [Month], product_id,
avg(stars) avgStars
from reviews
group by cast(month(submit_date)as int),product_id

/**Question 2: Intel Products Manufacturing Data.
Intel, as a pioneering company in the semiconductor industry, 
has a large scale of manufacturing operations. There is a 
continuous need to monitor and analyze the manufacturing data 
to drive optimizations and maintain high-quality standards. 
Let's assume Intel has a products table that keeps track of each 
product and its manufacturing details, and an inspection table that 
stores the quality inspection results for each product.

Our task is to design related database tables, and write a PostgreSQL query 
to find and list all products that have failed quality inspection more than 
once last month.**/

drop table if exists products
create table products
(product_id int not null,
product_name varchar(50) not null,
[**manufacturing_date**] date not null)

insert into products
values
(01,'Processor_A','06-18-2022'),
(02,'Processor_B','06-20-2022'),
(03,'Memory_C','06-21-2022'),
(04,'Memory_D','06-25-2022'),
(05,'Modem_E','06-26-2022')

select * from products

drop table if exists inspection
create table inspection
(inspection_id int not null,
product_id varchar(10) not null,
inspection_date date not null,
result varchar(50) not null)

insert into inspection
values
(1001,'01','11-01-2024','Pass'),
(1002,'01','11-08-2024','Fail'),
(1003,'02','11-10-2024','Fail'),
(1004,'02','11-12-2024','Pass'),
(1005,'02','11-15-2024','Fail')

select * from inspection
select B.product_name,A.result,
count(B.product_id) Count
from inspection A join products B
on A.product_id=B.product_id
where result='fail'
and DATEPART(Month, A.inspection_date)=DATEPART(Month,DATEADD(month, -1, getdate()))
group by B.product_name,A.result
having count(B.product_id) > 1


/**Question 3: Can you describe the role of the CHECK constraint and provide an example of a situation where it might be applied?
The CHECK constraint is used to enforce rules on the data in a specific column. If a row is inserted or updated with data that does 
not follow the CHECK constraint's rule, the operation will fail.

For example, say you had a database that stores ad campaign data from Intel's Google Analytics account.

Here's what some constraints could look like: **/

CREATE TABLE ad_campaigns (
    ad_id INTEGER PRIMARY KEY,
    ad_name VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    budget DECIMAL(10,2) NOT NULL CHECK (budget > 0),
    cost_per_click DECIMAL(10,2) NOT NULL CHECK (cost_per_click > 0)
);

/** In this example, the CHECK constraint is used to ensure that the "budget" and "cost_per_click" fields have 
positive values. This helps to ensure that the data in the database is valid and makes sense in the context of ad campaigns.
You can also use the CHECK constraint to ensure that data meets other specific conditions. For example, you could use 
a CHECK constraint to ensure that the "start_date" is before the "end_date" for each ad campaign.**/


/**Question 4: Calculating Click-through-rate for Intel Ads
Given a table of user click events on intel's digital advertisement and another table for user purchases, calculate
the click-through conversion rate, defined as the number of users who made a purchase after clicking the ad divided by the total 
number of users who clicked the ad.**/

-- Create the ad_clicks table
drop table if exists ad_clicks
CREATE TABLE ad_clicks (
    click_id INT PRIMARY KEY,
    user_id VARCHAR(10),
    click_time DATETIME,
    ad_id INT
);

-- Insert data into the ad_clicks table
INSERT INTO ad_clicks (click_id, user_id, click_time, ad_id)
VALUES
(4012, '001', '2022-06-10 12:00:00', 8451),
(1435, '002', '2022-06-10 14:00:00', 5984),
(6541, '003', '2022-06-11 08:00:00', 8451),
(9765, '004', '2022-06-11 10:00:00', 8451),
(3568, '005', '2022-06-12 20:00:00', 5984);

-- Create the purchases table
drop table if exists purchases
CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    user_id VARCHAR(10),
    purchase_date DATETIME,
    product_id INT
);

-- Insert data into the purchases table
INSERT INTO purchases (purchase_id, user_id, purchase_date, product_id)
VALUES
('0451', '001', '2022-06-10 15:00:00', 8923),
(3782, '001', '2022-06-10 16:00:00', 3398),
(8600, '002', '2022-06-10 17:00:00', 1112),
(7416, '006', '2022-06-12 12:00:00', 8923),
(9928, '003', '2022-06-12 23:00:00', 1112);


select * from purchases
select * from ad_clicks
;

WITH clicks AS 
(
    SELECT user_id
    FROM ad_clicks
), 
purchase AS (
    SELECT user_id
    FROM purchases
    WHERE user_id IN (SELECT user_id FROM clicks)
),
total_clicks AS (
    SELECT COUNT(*) AS total
    FROM clicks
),
total_purchase AS (
    SELECT COUNT(*) AS total
    FROM purchases
)
SELECT 
    CAST(total_purchase.total AS DECIMAL(10, 2)) / 
	CAST(total_clicks.total AS DECIMAL(10, 2)) * 100 AS click_through_conversion_rate
FROM 
    total_clicks, 
    total_purchase;

	/**Question 5: What's the purpose of the COALESCE() function in SQL?

Answer: To get rid of these NULLs, and replace them with zero's (so you can do some further analytics 
		like find the average number of closed deals)

  Question 6: Average Rating per CPU Product 
  In Intel, we are interested in the performance and quality of our CPU (Central Processing Unit) products over time. 
  One way of gauging product performance is by analyzing the ratings given by our customers. As a data analyst, 
  we need you to write a query that will provide us with the average rating (stars) per CPU product for each year.

For this question, we are assuming that we have 2 tables. The first table is products and the other is reviews **/

select *
from products

select * 
from reviews

select product_id,
cast(year(submit_date) as int) as year,
avg(stars) AvgRating
from reviews
group by product_id,
cast(year(submit_date) as int)

/**Question 7: What are the different kinds of joins in SQL?

In SQL, a join retrieves rows from multiple tables and combines them into a single result set.

Four JOIN types can be found in SQL. For an example of each one, suppose you had a table of Intel orders and Intel customers.

INNER JOIN: Rows from both tables are retrieved when there is a match in the shared key or keys. An INNER JOIN between the Orders 
			and Customers tables would return only rows where the customer_id in the Orders table matches the customer_id in the 
			Customers table.

LEFT JOIN: A LEFT JOIN retrieves all rows from the left table (in this case, the Orders table) and any matching rows from the right 
			table (the Customers table). If there is no match in the right table, NULL values will be returned for the right table's 
			columns.

RIGHT JOIN: A RIGHT JOIN combines all rows from the right table (in this case, the Customers table) and any matching rows from the 
			left table (the Orders table). If there is no match in the left table, NULL values will be displayed for the left table's 
			columns.

FULL OUTER JOIN: A FULL OUTER JOIN combines all rows from both tables, regardless of whether there is a match in the shared key or keys.
				If there is no match, NULL values will be displayed for the columns of the non-matching table.

Question 8: Find Intel Employees
			Intel Corp. wants to filter through its employee database to find employees who have 'Systems Engineer' in their job titles
			and who got hired in the year 2020. The 'intel_employees table consists of the fields 'employee_id','name','job_title','hire_date',
			'salary' and 'dept_name'.**/

-- Create the intel_employees table
CREATE TABLE intel_employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    job_title VARCHAR(50),
    hire_date DATE,
    salary INT,
    dept_name VARCHAR(50)
);

-- Insert data into the intel_employees table
INSERT INTO intel_employees (employee_id, name, job_title, hire_date, salary, dept_name)
VALUES
(2312, 'John Doe', 'Systems Engineer', '2020-05-17', 60000, 'Software'),
(8725, 'Diana Prince', 'Software Developer', '2019-09-10', 75000, 'Software'),
(6139, 'Clark Kent', 'Systems Analyst', '2018-03-24', 53000, 'Systems'),
(9408, 'Bruce Wayne', 'Systems Engineer', '2020-01-15', 62000, 'Systems'),
(7690, 'Peter Parker', 'Database Administrator', '2021-06-12', 56000, 'Database');


select *
from intel_employees
where job_title='Systems Engineer'
and year(hire_date) = 2020

/**Question 9: Purchase Analysis Combined From Customers and Products
Analyze the purchasing behavior of Intel's customers and identify the most bought product. The analysis will be based on two tables: 
customers and purchases.
The customers table has five columns: customer_id, first_name, last_name, email and created_at (the date when the customer was added).
The question is to write a SQL query that returns the most purchased product by customers in Intel. If more than one product has the 
most purchases, return all of them.**/

-- Create the intel_customers table
CREATE TABLE intel_customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    created_at DATE
);

-- Insert data into the intel_customers table
INSERT INTO intel_customers (customer_id, first_name, last_name, email, created_at)
VALUES
(1, 'John', 'Doe', 'johndoe@example.com', '2020-10-21'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '2020-11-03'),
(3, 'Dave', 'Jones', 'davejones@example.com', '2021-01-15'),
(4, 'Mary', 'Johnson', 'maryjohnson@example.com', '2021-04-25'),
(5, 'Robert', 'Brown', 'robertbrown@example.com', '2021-08-12');

-- Create the intel_purchases table
CREATE TABLE intel_purchases (
    purchase_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    purchase_date DATE
);

-- Insert data into the intel_purchases table
INSERT INTO intel_purchases (purchase_id, customer_id, product_id, purchase_date)
VALUES
(100, 1, 15, '2020-10-22'),
(101, 2, 17, '2021-03-17'),
(102, 1, 18, '2021-06-29'),
(103, 4, 15, '2021-06-01'),
(104, 1, 17, '2021-09-10'),
(105, 2, 15, '2022-01-10');

select * from intel_customers
select * from intel_purchases

select *,
DENSE_RANK() over(order by product_id desc) as Rank
from intel_purchases;

select product_id,count(*) as PurchasedProductCount
from intel_purchases
group by product_id
having count(*) = (
select max(purchasedproductcount) maxpurchase
from (
select count(*) as PurchasedProductCount
from intel_purchases
group by product_id) x)

/**Question 10: What sets the 'BETWEEN' and 'IN' operators apart?
 
 The BETWEEN and IN operators are both used to filter data based on certain criteria, but they work in different ways. 
 BETWEEN is used to select values within a range, while IN is used to select values that match a list. 
 For instance, if you have a table called intel_employees that contains the salary of each employee, along with which 
 country they reside in, you could use the BETWEEN operator to find all employees who make between 130kand160k:
 To find all employees that reside in France and Germany, you could use the IN operator: