/*
Developer: Emmanuel Olaiya
Code Description: 
				This is to perform data analytics and Data Analysis on the sales, customer and order data.
				This file contains the solutions of all the tasks. 
				After completing the assigned tasks or Questions refer this file for correction
Create Date: 2025-04-12
Version: v1.0
*/

select * from SalesCustomers;
--# Sample:- How many SalesCustomers are male and female?

select gender , count(*) TotalSalesCustomersByGender
from SalesCustomers
group by gender;

/* BASIC SQL QUESTIONS */

--# Q1. How many SalesCustomers do not have DOB information available?

select count(*) 'SalesCustomers do not have DOB'
from SalesCustomers 
where dob is null;


--# Q2-- How many SalesCustomers are there in each SalesPinCode and gender combination?
select primary_pincode, gender, 
count(cust_id) as TotalSalesCustomers
from SalesCustomers
group by primary_pincode, gender
order by primary_pincode desc;


--# Q3--  Print product name and mrp for SalesProducts which have more than 50000 MRP? 

select product_name, mrp 
from SalesProducts 
where mrp>50000;

--# Q4. How many delivery personal are there in each SalesPinCode?

--select * from SalesDeliveryPerson

select pincode, count(delivery_person_id) as 'delivery personal'
from SalesDeliveryPerson
group by pincode;

/* --Q5. For each Pin code, print the count of SalesOrders, sum of total amount paid, average amount paid, maximum amount paid,
 minimum amount paid for the transactions which were paid by 'cash'. 
Take only 'buy' order types
*/

select delivery_PinCode as pd , 
count(order_id) 'count of SalesOrders', 
sum(total_amount_paid) 'sum of total amount paid', 
avg(total_amount_paid) 'average amount paid', 
max(total_amount_paid) 'maximum amount paid',
min(total_amount_paid) 'minimum amount paid'
from SalesOrders
where payment_type='cash' and order_type='buy'
group by delivery_PinCode;

/*
--Q6. For each SalesDeliveryPerson_id, print the count of SalesOrders and 
total amount paid for product_id = 12350 or 12348 and total units > 8. 
Sort the output by total amount paid in descending order. Take only 'buy' order types
*/

select Delivery_Person_id as DeliveryPersonId, 
count(order_id) TotalOrder,
sum(total_amount_paid) as TotalAmountPaid 
from SalesOrders
where product_id IN (12348,12350)
and tot_units>8 and order_type='buy'
group by Delivery_Person_id
order by TotalAmountPaid desc;

--# Q7. Print the Full names (first name plus last name) for SalesCustomers that have email on 'gmail.com'?
select concat(first_name,' ',last_name) as 'Full names' ,email
from SalesCustomers
where email like '%gmail%';

--OR
select (first_name +' '+ last_name) as 'Full names' ,email
from SalesCustomers
where email like '%gmail%';


--# Q8. How many SalesOrders had #units between 1-3, 4-6 and 7+? Take only 'buy' order types
select 
case 
when tot_units<=3 then '1-3'
when tot_units>=4 and tot_units<=6 then '4-6'
else '7+'
end as Category,
count(order_id) as TotalOrder
from SalesOrders
where order_type='buy'
group by 
case 
when tot_units<=3 then '1-3'
when tot_units>=4 and tot_units<=6 then '4-6'
else '7+'
end
order by TotalOrder;

--# Q9. Which SalesPinCode has average amount paid more than 150,000? Take only 'buy' order types

select delivery_PinCode as Delivery_PinCode, 
avg(total_amount_paid) as TotalAveragePaid
from SalesOrders
where order_type='buy'
 group by delivery_PinCode
 having avg(total_amount_paid)>150000;

/* Q10. Create following columns from order data.Take only 'buy' order types

order_date
Order day
Order month
Order year */
 
 select order_date, 
 DAY(order_date) as order_day,
 MONTH(order_date) as order_month,
 YEAR(order_date) as order_year
 from SalesOrders
 where order_type='buy';

/* Q11. How many total SalesOrders were there in each month and how many of them were returned? Add a column for return rate too.
return rate = (100.0 * total return SalesOrders) / total buy SalesOrders
Hint: You will need to combine SUM() with CASE WHEN
*/
 with cte as
 (
 select  MONTH(order_date) as order_month,
 sum(case when order_type='return' then 1 else 0 end) as Total_Returns,
 sum(case when order_type='buy' then 1 else 0 end) as Total_buys
 from SalesOrders
 group by order_date
 )
 select c.*
 from cte c
;

 --code
  select  MONTH(order_date) as order_month,
 sum(case when order_type='return' then 1 else 0 end) as Total_Returns,
 sum(case when order_type='buy' then 1 else 0 end) as Total_buys
 from SalesOrders
 group by order_date
 
 
 --# QUESTION ON SQL JOINS
 
 --# Q12. How many units have been sold by each brand? Also get total returned units for each brand.
 
 select p.brand, 
 sum(case when order_type='buy' then o.tot_units end)  TotalUnitsSoldByBrand
 from SalesProducts p 
 inner join SalesOrders o ON
 p.product_id=o.product_id
 group by p.brand;

 

-- # Q13. How many unique SalesCustomers and delivery boys are there in each state?

 select p.state, count(distinct c.cust_id) as SalesCustomers, 
 count(distinct dp.delivery_person_id) as Delivery_Man 
 from SalesPinCode p 
 inner join SalesCustomers c
 ON p.pincode=c.primary_pincode
 inner join SalesDeliveryPerson dp 
 ON p.pincode=dp.PinCode
 group by p.state;


/* Q14. For every customer, print how many total units were ordered, how many units were 
ordered from their primary_SalesPinCode and how many were ordered not from the primary_SalesPinCode. 
Also calulate the percentage of total units which were ordered from 
primary_SalesPinCode(remember to multiply the numerator by 100.0). Sort by the percentage column in descending order.
*/ 

 select c.cust_id, sum(o.tot_units)as Total_SalesOrders,
 sum(case when c.primary_pincode=o.delivery_pincode then o.tot_units else 0 end) as Same_city,
 sum(case when c.primary_pincode!=o.delivery_pincode then o.tot_units else 0 end) as Diff_city
 from SalesCustomers c 
 inner join SalesOrders o 
 ON c.cust_id=o.cust_id
 where o.order_type='buy'
 group by c.cust_id;
 
 
 /* Task 15 
 For each product name, print the sum of number of units, total amount paid, 
 total displayed selling price, total mrp of these units, and finally the net discount from selling price 
 (i.e. 100.0 - 100.0 * total amount paid / total displayed selling price) 
 AND the net discount from mrp (i.e. 100.0 - 100.0 * total amount paid / total mrp)
*/
 
 with cte as
 (
 select p.product_name, 
 sum(o.tot_units) as units, 
 sum(o.total_amount_paid) as Total_Amount_Paid,
 sum(o.tot_units*o.displayed_selling_price_per_unit) as Total_Display_Price, 
 sum(o.tot_units*p.mrp) as Total_MRP 
 from SalesProducts p 
 left join SalesOrders o
 ON p.product_id = o.product_id
 group by p.product_name
 )
 select *, 100-((total_amount_paid/total_display_price)*100) as Net_SP_discount,
 100-((total_amount_paid/total_mrp)*100) as Net_MRP_discount 
 from cte;

 /* Task 16
 For every order_id (exclude returns), get the product name and calculate the discount 
 percentage from selling price. Sort by highest discount and print only
 those rows where discount percentage was above 10.10%.
 */


/* Task 17
Using the per unit procurement cost in product table, find which product category has made the most profit in both absolute amount and percentage
Absolute Profit = Total Amt Sold - Total Procurement Cost
Percentage Profit = 100.0 * Total Amt Sold / Total Procurement Cost - 100.0 
*/

with cte as
(
select p.category as category,
sum(o.tot_units) as Units_Sold, 
sum(o.tot_units*procurement_cost_per_unit) as Total_Cost, 
sum(total_amount_paid) as Revenue
 from SalesProducts p 
 left join SalesOrders o 
ON p.product_id=o.product_id
group by p.category
) 
select category, Revenue-total_cost as Absolute_Profit, 
100-((total_cost/revenue)*100) as Percentage_Profit 
from cte;

/* Task 19
For each gender - male and female - find the absolute and percentage profit (like in Q16) by product name
*/


with cte as
(
select c.gender,p.category as category, 
sum(tot_units) as Total_units, 
sum(total_amount_paid) as Amount_Paid,
sum(p.procurement_cost_per_unit*o.tot_units) as Total_Cost
from SalesCustomers c 
left join SalesOrders o
ON c.cust_id = o.cust_id
inner join SalesProducts p
ON o.product_id=p.product_id
where o.order_type='buy'
group by c.gender,p.category
--order by c.gender
)
select gender,category, Amount_paid-total_cost as Abs_Profit,
100-((total_cost/amount_paid)*100) as Profit from cte;
 
 
 /* Task 20 
 Generally the more numbers of units you buy, the more discount seller will give you.
 For 'Dell AX420' is there a relationship between number of units ordered and average discount 
 from selling price? Take only 'buy' order types
 */
 
select o.tot_units, 
(avg(o.displayed_selling_price_per_unit*o.tot_units)-avg(o.total_amount_paid)) as Average_discount 
from SalesOrders o inner join SalesProducts p
ON o.product_id=p.product_id
where p.product_name='Dell AX420' and o.order_type='buy'
group by o.tot_units
order by o.tot_units;
 