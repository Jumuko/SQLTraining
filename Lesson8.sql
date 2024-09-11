CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    order_date DATE,
    product_name VARCHAR(100),
    quantity INT,
    discount DECIMAL(10, 2),
    total_price DECIMAL(10, 2)
);

INSERT INTO orders (order_id, customer_name, order_date, product_name, quantity, discount, total_price)
VALUES
    (1, 'John Doe', '2023-09-15', 'Product A', 3, 1.20, 150.75),
    (2, 'Jane Smith', '2023-09-16', 'Product B', 2, 1.01, 75.50),
    (3, 'Alice Johnson', '2023-09-17', 'Product C', 5, 0.5, 199.95),
    (4, 'Bob Brown', '2023-09-18', 'Product A', 1, NULL, 112.9),
    (5, 'Eva Davis', '2023-09-19', 'Product D', 4, 4.23, 299.80),
    (6, 'Michael Wilson', '2023-09-20', 'Product B', 3, 0.61, NULL),
    (7, NULL, '2023-09-21', 'Product E', 2, 1.41, 129.98),
    (8, 'David White', '2023-09-22', 'Product C', NULL, 0.98, 79.98),
    (9, 'Linda Johnson', '2023-09-23', 'Product A', 6, 3.87, 301.50),
    (10, 'William Smith', '2023-09-23', 'Product D', 3, 0.43, 224.85);

	select *
	from orders

	--show a report that shows product ordered without customer infomation(customer name)
	select *
	from orders
	where customer_name is NULL

	--How many customers do we have on the orders table
	select 
	count(customer_name) as NumberofCustomers
	from orders

	--coalesce is one way to handle nulls
select order_id,
coalesce(customer_name,'N/A') NewCustomerName,
customer_name,
order_date,
product_name,
quantity,
discount,
total_price
from orders


--Another approach
select [order_id], [customer_name], [order_date], [product_name], [quantity], [discount], [total_price],
case
when customer_name is Null then 'N/A'
else customer_name
end as NewCustomerName
from orders

--Another approach
--show a report that shows product ordered without quantity infomation

select *
	from orders
	where quantity is NULL

	select [order_id], [customer_name], [order_date], [product_name], [quantity], [discount], [total_price],
case
when quantity is Null then 0
else quantity
end as NewQuantity
from orders

--for discount
select order_id,
coalesce(discount,0) NewDiscount,
customer_name,
order_date,
product_name,
quantity,
discount,
total_price
from orders

--for total price
select order_id,
coalesce(total_price,0) NewTotalPrice,
coalesce(discount,10) NewDiscount,
customer_name,
order_date,
product_name,
quantity,
discount,
total_price
from orders

CREATE TABLE EmadeconsultingEmployee
(    
name varchar(45) NOT NULL,      
occupation varchar(35) NOT NULL,      
working_date date,    
working_hours varchar(10),  
salary INT  
);  

INSERT INTO EmadeconsultingEmployee VALUES      
('Jolly Evans', 'HR', '2020-10-04', 9, 25000),    
('Brayden Simmons', 'Engineer', '2020-10-04', 12, 65000),    
('Rose Huges', 'Writer', '2020-10-04', 13, 35000),    
('Laura Paul', 'Manager', '2020-10-04', 10, 45000),    
('Diego Simmons', 'Teacher', '2020-10-04', 12, 30000),    
('Antonio Bennet', 'Writer', '2020-10-04', 13, 35000);

select *
from EmadeconsultingEmployee

/**
Questions: 
1:Write a query that returns the total number of employees data stored in the Emadeconsultingemployee table.
2: Write a query that calculates the total summed up salary of all employees stored in the Emadeconsultingemployee table
3: Write a query that calculates the average salary of employees stored in the Emadeconsultingemployee table.
4: Write a query that returns the lowest salary of an employee stored in the Emadeconsultingemployee table.
5: Write a query that returns the highest salary of employees stored in the Emadeconsultingemployee table.
**/

--Write a query that returns the total number of employees data stored in the Emadeconsultingemployee table
select
count(name) as TotalNoEmployee
from EmadeconsultingEmployee

--Write a query that calculates the total summed up salary of all employees stored in the Emadeconsultingemployee table
select 
sum(salary) as TotalSalary
from EmadeconsultingEmployee

--Write a query that calculates the average salary of employees stored in the Emadeconsultingemployee table
select 
avg(salary) as AvgSalary
from EmadeconsultingEmployee

--Write a query that returns the lowest salary of an employee stored in the Emadeconsultingemployee table
select top 1 *
from EmadeconsultingEmployee
order by salary asc

--Write a query that returns the highest salary of employees stored in the Emadeconsultingemployee table
select top 1 *
from EmadeconsultingEmployee
order by salary desc

select *
from EmadeconsultingEmployee
where salary =
(
select 
max(salary) as HighestSalary
from EmadeconsultingEmployee
)

--We need to update salary based on the working hours
