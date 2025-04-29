select * from EmadeMarketingDataDictionary
select * from EmadeMarketingData

/**
Top Spending Customers: Who are the top 10 customers by total amount spent 
						across all product categories?
**/
SELECT TOP 10 
    ID,
    (MntWines + MntFruits + MntMeatProducts + MntFishProducts 
	+ MntSweetProducts + MntGoldProds) AS TotalSpent
FROM dbo.EmadeMarketingData
ORDER BY TotalSpent DESC;

/**
Channel Effectiveness: Which sales channel contributes the most to customer purchases?
**/
SELECT 
    'Web' AS Channel, SUM(NumWebPurchases) AS Total FROM dbo.EmadeMarketingData
UNION ALL
SELECT 
    'Catalog', SUM(NumCatalogPurchases) FROM dbo.EmadeMarketingData
UNION ALL
SELECT 
    'Store', SUM(NumStorePurchases) FROM dbo.EmadeMarketingData
ORDER BY Total DESC;

/**
Customer Loyalty: Which customers have the highest total number of purchases across all channels?
**/
SELECT 
    ID,
    (NumWebPurchases + NumCatalogPurchases + NumStorePurchases) AS TotalPurchases
FROM dbo.EmadeMarketingData
ORDER BY TotalPurchases DESC;

/**
Age and Spending Trends: How does customer spending vary across different age groups?"
**/
SELECT 
    CASE 
        WHEN Year_Birth >= 2000 THEN 'Gen Z'
        WHEN Year_Birth >= 1981 THEN 'Millennials'
        WHEN Year_Birth >= 1965 THEN 'Gen X'
        WHEN Year_Birth >= 1946 THEN 'Boomers'
        ELSE 'Silent Gen'
    END AS AgeGroup,
    AVG(MntWines + MntFruits + MntMeatProducts + MntFishProducts 
	+ MntSweetProducts + MntGoldProds) AS AvgSpending
FROM dbo.EmadeMarketingData
GROUP BY 
    CASE 
        WHEN Year_Birth >= 2000 THEN 'Gen Z'
        WHEN Year_Birth >= 1981 THEN 'Millennials'
        WHEN Year_Birth >= 1965 THEN 'Gen X'
        WHEN Year_Birth >= 1946 THEN 'Boomers'
        ELSE 'Silent Gen'
    END;

/**
Campaign Effectiveness: What is the acceptance rate for each marketing campaign?
**/
SELECT 
    'Cmp1' AS Campaign, SUM(AcceptedCmp1) AS Accepted, COUNT(*) AS Total,
    CAST(SUM(AcceptedCmp1) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS AcceptanceRate
FROM dbo.EmadeMarketingData
UNION ALL
SELECT 
    'Cmp2', SUM(AcceptedCmp2), COUNT(*),
    CAST(SUM(AcceptedCmp2) * 100.0 / COUNT(*) AS DECIMAL(5,2)) 
FROM dbo.EmadeMarketingData
UNION ALL
SELECT 
    'Cmp3', SUM(AcceptedCmp3), COUNT(*),
    CAST(SUM(AcceptedCmp3) * 100.0 / COUNT(*) AS DECIMAL(5,2)) 
FROM dbo.EmadeMarketingData
UNION ALL
SELECT 
    'Cmp4', SUM(AcceptedCmp4), COUNT(*),
    CAST(SUM(AcceptedCmp4) * 100.0 / COUNT(*) AS DECIMAL(5,2)) 
FROM dbo.EmadeMarketingData
UNION ALL
SELECT 
    'Cmp5', SUM(AcceptedCmp5), COUNT(*),
    CAST(SUM(AcceptedCmp5) * 100.0 / COUNT(*) AS DECIMAL(5,2)) 
FROM dbo.EmadeMarketingData;

/**
Household Dynamics: How does the presence of children or teenagers in a home affect total spending?
**/
SELECT 
    Kidhome,
    Teenhome,
    AVG(MntWines + MntFruits + MntMeatProducts + MntFishProducts 
	+ MntSweetProducts + MntGoldProds) AS AvgSpending
FROM dbo.EmadeMarketingData
GROUP BY Kidhome, Teenhome;

/**
Web Engagement: How does web visit frequency correlate with purchase behavior?
**/
SELECT 
    NumWebVisitsMonth,
    AVG(NumWebPurchases) AS AvgWebPurchases
FROM dbo.EmadeMarketingData
GROUP BY NumWebVisitsMonth
ORDER BY NumWebVisitsMonth;

/**
Customer Recency Impact: Does more recent customer activity indicate higher spending?
**/
SELECT 
    Recency,
    AVG(MntWines + MntFruits + MntMeatProducts + MntFishProducts 
	+ MntSweetProducts + MntGoldProds) AS AvgSpending
FROM dbo.EmadeMarketingData
GROUP BY Recency
ORDER BY Recency ASC;

/**
Geographic Insights: What are the top 5 countries by average income of customers?
**/
SELECT TOP 5 
    Country,
    AVG([ Income ]) AS AvgIncome
FROM dbo.EmadeMarketingData
GROUP BY Country
ORDER BY AvgIncome DESC;

/**
Complaint Insights: Do customers who complain spend less than those who do not?"
**/
SELECT 
    Complain,
    AVG(MntWines + MntFruits + MntMeatProducts + MntFishProducts 
	+ MntSweetProducts + MntGoldProds) AS AvgSpending
FROM dbo.EmadeMarketingData
GROUP BY Complain;
