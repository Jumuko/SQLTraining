

select * from SalesCustomers

truncate table HealthInsuranceClaim
truncate table HealthInsuranceClaimAddress
truncate table HealthInsuranceClaimPayment
truncate table HealthInsuranceCoverage
truncate table HealthInsuranceMembers
truncate table HealthInsuranceProvider
truncate table HealthInsuranceStatus

select * from HealthInsuranceClaim
select * from HealthInsuranceClaimAddress
select * from HealthInsuranceClaimPayment
select * from HealthInsuranceCoverage
select * from HealthInsuranceMembers
select * from HealthInsuranceProvider
select * from HealthInsuranceStatus


SELECT member_id, member_dob
FROM HealthInsuranceMembers

select distinct coverage_name, count(member_id) as Members from HealthInsuranceCoverage group by coverage_name


drop table if exists HealthInsuranceClaim
drop table if exists HealthInsuranceClaimAddress
drop table if exists HealthInsuranceClaimPayment
drop table if exists HealthInsuranceProvider
drop table if exists HealthInsuranceMembers
drop table if exists HealthInsuranceStatus
drop table if exists HealthInsuranceCoverage

--Number of claims by age group
create view vwClaimsByAgeGroup as
SELECT
    CASE 
        WHEN DATEDIFF(YEAR, member_dob, GETDATE()) < 18 THEN '0-17'
        WHEN DATEDIFF(YEAR, member_dob, GETDATE()) BETWEEN 18 AND 34 THEN '18-34'
        WHEN DATEDIFF(YEAR, member_dob, GETDATE()) BETWEEN 35 AND 49 THEN '35-49'
        WHEN DATEDIFF(YEAR, member_dob, GETDATE()) BETWEEN 50 AND 64 THEN '50-64'
        ELSE '65+'
    END AS age_group,
    COUNT(*) AS Claims
FROM
    HealthInsuranceMembers
WHERE
    member_dob IS NOT NULL
GROUP BY
    CASE 
        WHEN DATEDIFF(YEAR, member_dob, GETDATE()) < 18 THEN '0-17'
        WHEN DATEDIFF(YEAR, member_dob, GETDATE()) BETWEEN 18 AND 34 THEN '18-34'
        WHEN DATEDIFF(YEAR, member_dob, GETDATE()) BETWEEN 35 AND 49 THEN '35-49'
        WHEN DATEDIFF(YEAR, member_dob, GETDATE()) BETWEEN 50 AND 64 THEN '50-64'
        ELSE '65+'
    END
ORDER BY
    age_group;

--Total claim payment by date
SELECT 
    c.date_of_service AS payment_date,
    SUM(p.net_payment) AS total_paid
FROM 
    HealthInsuranceClaimPayment p
JOIN 
    HealthInsuranceClaim c ON p.claim_id = c.claim_id
GROUP BY 
    c.date_of_service
ORDER BY 
    c.date_of_service;

--Total claim payment by status
SELECT 
    s.claim_status,
    SUM(p.net_payment) AS total_paid
FROM 
    HealthInsuranceClaimPayment p
JOIN 
    HealthInsuranceClaim c ON p.claim_id = c.claim_id
JOIN 
    HealthInsuranceStatus s ON c.status_id = s.status_id
GROUP BY 
    s.claim_status
ORDER BY 
    total_paid DESC;

--No of claims by county
SELECT 
    a.county,
    COUNT(c.claim_id) AS total_claims
FROM 
    HealthInsuranceClaim c
JOIN 
    HealthInsuranceMembers m ON c.claim_id = m.claim_id
JOIN 
    HealthInsuranceClaimAddress a ON m.address_id = a.address_id
GROUP BY 
    a.county
ORDER BY 
    total_claims DESC;

--Top number of claims by country
SELECT 
    a.country,
    COUNT(c.claim_id) AS Numberofclaims
FROM 
    HealthInsuranceClaim c
JOIN 
    HealthInsuranceMembers m ON c.claim_id = m.claim_id
JOIN 
    HealthInsuranceClaimAddress a ON m.address_id = a.address_id
GROUP BY 
    a.country
ORDER BY 
    Numberofclaims DESC;

--Number of claims versus claim status by month
SELECT 
    Datename(month, c.date_of_service) AS claim_month,
    s.claim_status,
    COUNT(c.claim_id) AS total_claims
FROM 
    HealthInsuranceClaim c
JOIN 
    HealthInsuranceStatus s ON c.status_id = s.status_id
GROUP BY 
    datename(month, c.date_of_service), s.claim_status
ORDER BY 
    claim_month, s.claim_status;

--Trend of claims filled quarterly.
SELECT datepart(QUARTER, date_of_service) AS Quarter, COUNT(*) AS total_claims
FROM HealthInsuranceClaim
GROUP BY datepart(QUARTER, date_of_service)
ORDER BY Quarter;

--Claim status categories
SELECT s.claim_status, COUNT(*) AS total_claims
FROM HealthInsuranceClaim c
JOIN HealthInsuranceStatus s ON c.status_id = s.status_id
GROUP BY s.claim_status
;
--Claims paid versus unpaid
SELECT 
    CASE WHEN p.claim_id IS NOT NULL THEN 'Paid' ELSE 'Unpaid' END AS payment_status,
    COUNT(*) AS claim_count
FROM HealthInsuranceClaim c
LEFT JOIN HealthInsuranceClaimPayment p ON c.claim_id = p.claim_id
GROUP BY CASE WHEN p.claim_id IS NOT NULL THEN 'Paid' ELSE 'Unpaid' END;


--High-Value Claims: Who are the top members whose approved claim amounts exceed $2200, and which providers are associated with them?SELECT 
    m.member_first_name + ' ' + m.member_last_name AS member_name,
    pr.provider_first_name + ' ' + pr.provider_last_name AS provider_name,
    p.approved_amount
FROM 
    HealthInsuranceClaim c
JOIN 
    HealthInsuranceStatus s ON c.status_id = s.status_id
JOIN 
    HealthInsuranceClaimPayment p ON c.claim_id = p.claim_id
JOIN 
    HealthInsuranceMembers m ON c.claim_id = m.claim_id
JOIN 
    HealthInsuranceProvider pr ON c.claim_id = pr.claim_id
WHERE 
   s.claim_status = 'paid' and p.approved_amount > 2500
GROUP BY 
    m.member_first_name, m.member_last_name,
    pr.provider_first_name, pr.provider_last_name, 
	p.approved_amount
ORDER BY 
    p.approved_amount DESC;

--Claim Tracking: Which members currently have claims in progress, and what are their demographic profiles?
SELECT m.member_first_name + ' ' + m.member_last_name AS member_name,s.claim_status,m.gender,m.member_dob
FROM 
    HealthInsuranceClaim c
JOIN 
    HealthInsuranceStatus s ON c.status_id = s.status_id
JOIN 
    HealthInsuranceMembers m ON c.claim_id = m.claim_id
WHERE 
   s.claim_status = 'in progress'
GROUP BY 
m.member_first_name, m.member_last_name, s.claim_status, m.gender, m.member_dob

--Plan Distribution: Which members are subscribed to coverage plans that are linked to address IDs within a specified operational range?**/
SELECT 
    Distinct m.member_first_name + ' ' + m.member_last_name AS member_name,
    c.coverage_name,
    a.address_id,
    a.county
FROM 
    HealthInsuranceMembers m
JOIN 
    HealthInsuranceCoverage c ON m.coverage_id = c.coverage_id
JOIN 
    HealthInsuranceClaimAddress a ON m.address_id = a.address_id

ORDER BY 
a.county
