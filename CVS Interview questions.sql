use dev
go

-- Create the cvs_products table
CREATE TABLE cvs_products (
    product_id INT PRIMARY KEY,
    units_sold INT,
    total_sales DECIMAL(15, 2),
    cogs DECIMAL(15, 2), -- Cost of Goods Sold
    manufacturer VARCHAR(100),
    drug VARCHAR(100)
);

-- Insert data into the cvs_products table
INSERT INTO cvs_products (product_id, units_sold, total_sales, cogs, manufacturer, drug)
VALUES
(156, 89514, 3130097.00, 3427421.73, 'Biogen', 'Acyclovir'),
(25, 222331, 2753546.00, 2974975.36, 'AbbVie', 'Lamivudine and Zidovudine'),
(50, 90484, 2521023.73, 2742445.90, 'Eli Lilly', 'Dermasorb TA Complete Kit'),
(41, 189925, 3499574.92, 3692136.66, 'AbbVie', 'Clarithromycin'),
(63, 93513, 2104765.00, 2462370.76, 'Johnson & Johnson', 'Pepcid AC Acid Reducer'),
(8, 177270, 2930134.52, 3035522.06, 'Johnson & Johnson', 'Nicorobin Clean and Clear'),
(75, 164674, 1184664.57, 1285326.93, 'Eli Lilly', 'RED GINSENG FERMENTED ESSENCE BB'),
(91, 97765, 1115255.32, 1201044.27, 'Roche', 'Hydrochlorothiazide'),
(26, 126866, 1499768.09, 1573992.41, 'Eli Lilly', 'LBel'),
(16, 51707, 1304837.86, 1378790.53, 'Roche', 'Topcare Tussin'),
(80, 61467, 3740527.69, 3804542.20, 'Biogen', 'Losartan Potassium'),
(148, 104637, 837620.18, 931084.25, 'Johnson & Johnson', 'Motrin'),
(95, 128494, 723841.23, 779520.88, 'Biogen', 'Wal-Zan'),
(56, 86598, 1755300.92, 1806344.97, 'Eli Lilly', 'Spot Repairing Serum'),
(71, 126265, 2564743.39, 2593528.67, 'Bayer', 'ENALAPRIL MALEATE'),
(35, 87449, 86938.27, 99811.26, 'Johnson & Johnson', 'Sanitary Wipes Plus'),
(70, 167190, 1119479.36, 1313174.69, 'Johnson & Johnson', 'Zyrtec Ultra-Strength'),
(15, 118901, 2717420.96, 2707620.02, 'Biogen', 'Clotrimazole'),
(33, 149895, 949514.05, 921206.75, 'Bayer', 'Levofloxacin'),
(179, 125006, 1825970.00, 1769907.97, 'Biogen', 'Lancome Paris Renergie Lift Volumetry'),
-- Add additional rows here as needed
(189, 99858, 84759462.01, 3243809.46, 'AbbVie', 'Humira');

select * from cvs_products

/**
CVS Health is trying to better understand its pharmacy sales, and how well different products are selling. 
Each drug can only be produced by one manufacturer.

Question 1
Write a query to find the top 3 most profitable drugs sold, and how much profit they made. Assume that there 
are no ties in the profits. Display the result from the highest to the lowest total profit.
Definition:
cogs stands for Cost of Goods Sold which is the direct cost associated with producing the drug.
Total Profit = Total Sales - Cost of Goods Sold**/

--Solution
select drug,
sum(total_sales-cogs) total_profit
from cvs_products
group by drug
order by total_profit desc

/**Question 2
Write a query to identify the manufacturers associated with the drugs that resulted in losses for CVS Health and 
calculate the total amount of losses incurred.
Output the manufacturer's name, the number of drugs associated with losses, and the total losses in absolute value. 
Display the results sorted in descending order with the highest losses displayed at the top.**/

--Solution
select manufacturer,
sum(total_sales-cogs) total_profit,
count(drug) as number_of_drugs
from cvs_products
group by manufacturer
having sum(total_sales-cogs) like '-%'
order by total_profit asc

;
/**Question 3
Write a query to calculate the total drug sales for each manufacturer. Round the answer to the nearest million and report 
your results in descending order of total sales. In case of any duplicates, sort them alphabetically by the manufacturer name.
Since this data will be displayed on a dashboard viewed by business stakeholders, please format your results as follows: 
"$36 million".**/

--solution
select manufacturer,
concat('$',ceiling(total_sales),'million') as total_sale
from(
select manufacturer,
sum(total_sales/1000000) as total_sales
--sum(total_sales) as TotalSales,
from cvs_products
group by manufacturer) x
order by manufacturer asc;

