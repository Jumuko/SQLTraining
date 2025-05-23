/**********************************************************************************************************************
DEVELOPER: JOHN O. UMUKORO, ARAMIDE AGBOOLA
DATE CREATED: 2025-04-14
CODE VERSION: 1.0
DESCRIPTION: THIS CODE PROVIDES INFORMATION ABOUT HEALTH INSURANCE CLAIMS
PROJECT SCOPE:  1: NORMALIZE AND LOAD ALL 7 HEATLH INSURANCE CLAIMS SYSTEM DATA INTO DATABASE
				2: CREATE AND DESIGN ERD
				3: CREATE SQL QUERIES TO GENERATE METRICS
				4: PRODUCE A BUSINESS INTELLIGENCE REPORT
**********************************************************************************************************************/


SELECT * FROM SALESCUSTOMERS

TRUNCATE TABLE HEALTHINSURANCECLAIM
TRUNCATE TABLE HEALTHINSURANCECLAIMADDRESS
TRUNCATE TABLE HEALTHINSURANCECLAIMPAYMENT
TRUNCATE TABLE HEALTHINSURANCECOVERAGE
TRUNCATE TABLE HEALTHINSURANCEMEMBERS
TRUNCATE TABLE HEALTHINSURANCEPROVIDER
TRUNCATE TABLE HEALTHINSURANCESTATUS

SELECT * FROM HEALTHINSURANCECLAIM
SELECT * FROM HEALTHINSURANCECLAIMADDRESS
SELECT * FROM HEALTHINSURANCECLAIMPAYMENT
SELECT * FROM HEALTHINSURANCECOVERAGE
SELECT * FROM HEALTHINSURANCEMEMBERS
SELECT * FROM HEALTHINSURANCEPROVIDER
SELECT * FROM HEALTHINSURANCESTATUS


SELECT MEMBER_ID, MEMBER_DOB
FROM HEALTHINSURANCEMEMBERS

SELECT DISTINCT COVERAGE_NAME, COUNT(MEMBER_ID) AS MEMBERS FROM HEALTHINSURANCECOVERAGE GROUP BY COVERAGE_NAME


DROP TABLE IF EXISTS HEALTHINSURANCECLAIM
DROP TABLE IF EXISTS HEALTHINSURANCECLAIMADDRESS
DROP TABLE IF EXISTS HEALTHINSURANCECLAIMPAYMENT
DROP TABLE IF EXISTS HEALTHINSURANCEPROVIDER
DROP TABLE IF EXISTS HEALTHINSURANCEMEMBERS
DROP TABLE IF EXISTS HEALTHINSURANCESTATUS
DROP TABLE IF EXISTS HEALTHINSURANCECOVERAGE

--NUMBER OF CLAIMS BY AGE GROUP
CREATE VIEW VWCLAIMSBYAGEGROUP AS
SELECT
    CASE 
        WHEN DATEDIFF(YEAR, MEMBER_DOB, GETDATE()) < 18 THEN '0-17'
        WHEN DATEDIFF(YEAR, MEMBER_DOB, GETDATE()) BETWEEN 18 AND 34 THEN '18-34'
        WHEN DATEDIFF(YEAR, MEMBER_DOB, GETDATE()) BETWEEN 35 AND 49 THEN '35-49'
        WHEN DATEDIFF(YEAR, MEMBER_DOB, GETDATE()) BETWEEN 50 AND 64 THEN '50-64'
        ELSE '65+'
    END AS AGE_GROUP,
    COUNT(*) AS CLAIMS
FROM
    HEALTHINSURANCEMEMBERS
WHERE
    MEMBER_DOB IS NOT NULL
GROUP BY
    CASE 
        WHEN DATEDIFF(YEAR, MEMBER_DOB, GETDATE()) < 18 THEN '0-17'
        WHEN DATEDIFF(YEAR, MEMBER_DOB, GETDATE()) BETWEEN 18 AND 34 THEN '18-34'
        WHEN DATEDIFF(YEAR, MEMBER_DOB, GETDATE()) BETWEEN 35 AND 49 THEN '35-49'
        WHEN DATEDIFF(YEAR, MEMBER_DOB, GETDATE()) BETWEEN 50 AND 64 THEN '50-64'
        ELSE '65+'
    END
ORDER BY
    AGE_GROUP;

--TOTAL CLAIM PAYMENT BY DATE
SELECT 
    C.DATE_OF_SERVICE AS PAYMENT_DATE,
    SUM(P.NET_PAYMENT) AS TOTAL_PAID
FROM 
    HEALTHINSURANCECLAIMPAYMENT P
JOIN 
    HEALTHINSURANCECLAIM C ON P.CLAIM_ID = C.CLAIM_ID
GROUP BY 
    C.DATE_OF_SERVICE
ORDER BY 
    C.DATE_OF_SERVICE;

--TOTAL CLAIM PAYMENT BY STATUS
SELECT 
    S.CLAIM_STATUS,
    SUM(P.NET_PAYMENT) AS TOTAL_PAID
FROM 
    HEALTHINSURANCECLAIMPAYMENT P
JOIN 
    HEALTHINSURANCECLAIM C ON P.CLAIM_ID = C.CLAIM_ID
JOIN 
    HEALTHINSURANCESTATUS S ON C.STATUS_ID = S.STATUS_ID
GROUP BY 
    S.CLAIM_STATUS
ORDER BY 
    TOTAL_PAID DESC;

--NO OF CLAIMS BY COUNTY
SELECT 
    A.COUNTY,
    COUNT(C.CLAIM_ID) AS TOTAL_CLAIMS
FROM 
    HEALTHINSURANCECLAIM C
JOIN 
    HEALTHINSURANCEMEMBERS M ON C.CLAIM_ID = M.CLAIM_ID
JOIN 
    HEALTHINSURANCECLAIMADDRESS A ON M.ADDRESS_ID = A.ADDRESS_ID
GROUP BY 
    A.COUNTY
ORDER BY 
    TOTAL_CLAIMS DESC;

--TOP NUMBER OF CLAIMS BY COUNTRY
SELECT 
    A.COUNTRY,
    COUNT(C.CLAIM_ID) AS NUMBEROFCLAIMS
FROM 
    HEALTHINSURANCECLAIM C
JOIN 
    HEALTHINSURANCEMEMBERS M ON C.CLAIM_ID = M.CLAIM_ID
JOIN 
    HEALTHINSURANCECLAIMADDRESS A ON M.ADDRESS_ID = A.ADDRESS_ID
GROUP BY 
    A.COUNTRY
ORDER BY 
    NUMBEROFCLAIMS DESC;

--NUMBER OF CLAIMS VERSUS CLAIM STATUS BY MONTH
SELECT 
    DATENAME(MONTH, C.DATE_OF_SERVICE) AS CLAIM_MONTH,
    S.CLAIM_STATUS,
    COUNT(C.CLAIM_ID) AS TOTAL_CLAIMS
FROM 
    HEALTHINSURANCECLAIM C
JOIN 
    HEALTHINSURANCESTATUS S ON C.STATUS_ID = S.STATUS_ID
GROUP BY 
    DATENAME(MONTH, C.DATE_OF_SERVICE), S.CLAIM_STATUS
ORDER BY 
    CLAIM_MONTH, S.CLAIM_STATUS;

--TREND OF CLAIMS FILLED QUARTERLY.
SELECT DATEPART(QUARTER, DATE_OF_SERVICE) AS QUARTER, COUNT(*) AS TOTAL_CLAIMS
FROM HEALTHINSURANCECLAIM
GROUP BY DATEPART(QUARTER, DATE_OF_SERVICE)
ORDER BY QUARTER;

--CLAIM STATUS CATEGORIES
SELECT 
    CASE 
        WHEN S.CLAIM_STATUS IN ('DENY', 'PEND') THEN 'UNRESOLVED'
        WHEN S.CLAIM_STATUS IN ('PAID') THEN 'APPROVED'
        WHEN S.CLAIM_STATUS IN ('IN PROGRESS') THEN 'PROCESSING'
        ELSE 'OTHER'
    END AS CLAIM_STATUS_GROUP,
    COUNT(*) AS TOTAL_CLAIMS
FROM 
    HEALTHINSURANCECLAIM C
JOIN 
    HEALTHINSURANCESTATUS S ON C.STATUS_ID = S.STATUS_ID
GROUP BY 
    CASE 
        WHEN S.CLAIM_STATUS IN ('DENY', 'PEND') THEN 'UNRESOLVED'
        WHEN S.CLAIM_STATUS IN ('PAID') THEN 'APPROVED'
        WHEN S.CLAIM_STATUS IN ('IN PROGRESS') THEN 'PROCESSING'
        ELSE 'OTHER'
    END
ORDER BY 
    TOTAL_CLAIMS DESC;

--HIGH-VALUE CLAIMS: WHO ARE THE TOP MEMBERS WHOSE APPROVED CLAIM AMOUNTS EXCEED $2200, AND WHICH PROVIDERS ARE ASSOCIATED WITH THEM?
SELECT 
    M.MEMBER_FIRST_NAME + ' ' + M.MEMBER_LAST_NAME AS MEMBER_NAME,
    PR.PROVIDER_FIRST_NAME + ' ' + PR.PROVIDER_LAST_NAME AS PROVIDER_NAME,
    P.APPROVED_AMOUNT
FROM 
    HEALTHINSURANCECLAIM C
JOIN 
    HEALTHINSURANCESTATUS S ON C.STATUS_ID = S.STATUS_ID
JOIN 
    HEALTHINSURANCECLAIMPAYMENT P ON C.CLAIM_ID = P.CLAIM_ID
JOIN 
    HEALTHINSURANCEMEMBERS M ON C.CLAIM_ID = M.CLAIM_ID
JOIN 
    HEALTHINSURANCEPROVIDER PR ON C.CLAIM_ID = PR.CLAIM_ID
WHERE 
   S.CLAIM_STATUS = 'PAID' AND P.APPROVED_AMOUNT > 2500
GROUP BY 
    M.MEMBER_FIRST_NAME, M.MEMBER_LAST_NAME,
    PR.PROVIDER_FIRST_NAME, PR.PROVIDER_LAST_NAME, 
	P.APPROVED_AMOUNT
ORDER BY 
    P.APPROVED_AMOUNT DESC;

--CLAIM TRACKING: WHICH MEMBERS CURRENTLY HAVE CLAIMS IN PROGRESS, AND WHAT ARE THEIR DEMOGRAPHIC PROFILES?
CREATE VIEW VWALLCLAIMTRACKING AS
SELECT S.CLAIM_STATUS,M.MEMBER_FIRST_NAME + ' ' + M.MEMBER_LAST_NAME AS MEMBER_NAME,M.GENDER,M.MEMBER_DOB
FROM 
    HEALTHINSURANCECLAIM C
JOIN 
    HEALTHINSURANCESTATUS S ON C.STATUS_ID = S.STATUS_ID
JOIN 
    HEALTHINSURANCEMEMBERS M ON C.CLAIM_ID = M.CLAIM_ID
--WHERE 
   --S.CLAIM_STATUS = 'IN PROGRESS'
GROUP BY 
S.CLAIM_STATUS, M.MEMBER_FIRST_NAME, M.MEMBER_LAST_NAME, M.GENDER, M.MEMBER_DOB

--PLAN DISTRIBUTION: WHICH MEMBERS ARE SUBSCRIBED TO COVERAGE PLANS THAT ARE LINKED TO ADDRESS IDS WITHIN A SPECIFIED OPERATIONAL RANGE?**/
SELECT 
    DISTINCT M.MEMBER_FIRST_NAME + ' ' + M.MEMBER_LAST_NAME AS MEMBER_NAME,
    C.COVERAGE_NAME,
    A.ADDRESS_ID,
    A.COUNTY
FROM 
    HEALTHINSURANCEMEMBERS M
JOIN 
    HEALTHINSURANCECOVERAGE C ON M.COVERAGE_ID = C.COVERAGE_ID
JOIN 
    HEALTHINSURANCECLAIMADDRESS A ON M.ADDRESS_ID = A.ADDRESS_ID

ORDER BY 
A.COUNTY

