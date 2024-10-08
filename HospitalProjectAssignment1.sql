﻿
/**********************************************************************************************************************
DEVELOPER: JOHN O. UMUKORO
DATE CREATED: 2024-10-3
CODE VERSION: 1.0
DESCRIPTION: THIS CODE PROVIDES INFORMATION ABOUT PATIENT ENCOUNTERS IN THE HOSPITAL

**********************************************************************************************************************/


--QUESTION 1: Write a query that does the following: Lists out number of patients in descending order,Does not include city Quincy,
--			  Must have at least 2 patients from that city
SELECT DISTINCT 
	CITY, 
	COUNT(ID) AS P
FROM PATIENTSDATA
WHERE CITY <> 'QUINCY'
GROUP BY CITY
HAVING COUNT(ID) > 1
ORDER BY CITY DESC


--QUESTION 2: find out the patients with the highest number of visits
WITH VISITS AS
		(
	SELECT DISTINCT 
		B.CITY,
		A.PATIENT,
		B.ID,
		COUNT(B.ID) AS NUMBEROFVISITS
	FROM ENCOUNTERSDATA A
		JOIN PATIENTSDATA B 
		ON A.PATIENT=B.ID
	GROUP BY B.CITY,A.PATIENT,B.ID
		)

SELECT *
FROM VISITS
WHERE NUMBEROFVISITS =
	(
	SELECT 
	MAX(NUMBEROFVISITS) AS MAXVISITS
	FROM VISITS
	);

--QUESTION 3: To find out the Top 10 patients with the most visits to the hospital
WITH VISITS AS
		(
	SELECT  
		B.CITY,
		A.PATIENT,
		B.ID,
		COUNT(B.ID) AS NUMBEROFVISITS
	FROM ENCOUNTERSDATA A
		JOIN PATIENTSDATA B 
		ON A.PATIENT=B.ID
	GROUP BY 
		B.CITY,
		A.PATIENT,
		B.ID
		)

SELECT 
	TOP 10 *
FROM VISITS
ORDER BY NUMBEROFVISITS DESC;

⁠-- QUESTION 4: To find out the number of times patients from each city visited the hospital
SELECT DISTINCT
	B.CITY,
	A.PATIENT,
	B.ID,
	COUNT(B.ID) AS NUMBEROFVISITS
FROM ENCOUNTERSDATA A
	JOIN PATIENTSDATA B 
	ON A.PATIENT=B.ID
GROUP BY 
	B.CITY,
	A.PATIENT,
	B.ID
ORDER BY NUMBEROFVISITS DESC;

--QUESTION 5: ⁠To find out the cities with up to 50 counts of emergency cases.
SELECT DISTINCT
	B.CITY,
	A.ENCOUNTERCLASS,
	COUNT(ENCOUNTERCLASS) AS COUNTSOFEMERGENCYCASES
FROM ENCOUNTERSDATA A
	JOIN PATIENTSDATA B 
	ON A.PATIENT=B.ID
WHERE ENCOUNTERCLASS = 'EMERGENCY'
GROUP BY 
B.CITY,
A.ENCOUNTERCLASS
HAVING COUNT(ENCOUNTERCLASS) >= 50
ORDER BY COUNTSOFEMERGENCYCASES DESC
;⁠

--QUESTION 6: ⁠Now to find out the number of patients from Boston who came in 2020
SELECT 
	B.CITY,
	COUNT(A.PATIENT) AS NUMBEROFPATIENTS
FROM ENCOUNTERSDATA A
	JOIN PATIENTSDATA B 
	ON A.PATIENT=B.ID
WHERE B.CITY = 'BOSTON' 
	AND START LIKE '2020%'
GROUP BY 
B.CITY;

-- QUESTION 7: To find out the top recurring conditions.
WITH RECCURRINGCONDITIONS AS
	(
	SELECT DISTINCT 
		A.DESCRIPTION,
		COUNT(*) AS NUMBEROFRECURRENCE
	FROM CONDITIONSDATA A
		JOIN PATIENTSDATA B 
		ON A.PATIENT=B.ID
	GROUP BY A.DESCRIPTION
	)
SELECT 
	TOP 5 DESCRIPTION,
	NUMBEROFRECURRENCE
FROM RECCURRINGCONDITIONS
ORDER BY NUMBEROFRECURRENCE DESC;


--QUESTION 8: To find out the month with the highest number of ambulatory cases since 2010
SELECT 
	TOP 1 NUMBEROFAMBULATORYCASES,
	YEAR,
	MONTH
FROM
	(
	SELECT DISTINCT
		DATEPART(YEAR, A.START) AS YEAR,
		DATEPART(MONTH, A.START) AS MONTH,
		COUNT(A.ENCOUNTERCLASS) AS NUMBEROFAMBULATORYCASES
	FROM ENCOUNTERSDATA A
		JOIN PATIENTSDATA B 
		ON A.PATIENT=B.ID
	WHERE ENCOUNTERCLASS = 'AMBULATORY'
	GROUP BY 
		DATEPART(YEAR, A.START), 
		DATEPART(MONTH, A.START)
	HAVING DATEPART(YEAR, A.START) >= 2010
	) X
 ORDER BY NUMBEROFAMBULATORYCASES DESC

--QUESTION 9: ⁠To find out the month with the highest number of emergency cases since 2010.

SELECT 
	TOP 1 NUMBEROFEMERGENCYCASES,
	YEAR,
	MONTH
FROM
	(
	SELECT DISTINCT
		DATEPART(YEAR, A.START) AS YEAR,
		DATEPART(MONTH, A.START) AS MONTH,
		COUNT(A.ENCOUNTERCLASS) AS NUMBEROFEMERGENCYCASES
	FROM ENCOUNTERSDATA A
		JOIN PATIENTSDATA B 
		ON A.PATIENT=B.ID
	WHERE ENCOUNTERCLASS = 'EMERGENCY'
	GROUP BY 
		DATEPART(YEAR, A.START), 
		DATEPART(MONTH, A.START)
	HAVING DATEPART(YEAR, A.START) >= 2010
	) X
ORDER BY NUMBEROFEMERGENCYCASES DESC

 --QUESTION 10: ⁠Now to find out the top 15 years with the most immunizations.
SELECT 
	TOP 15 NUMBEROFIMMUNIZATIONS,
	YEAR
FROM
	(
	SELECT DISTINCT
		DATEPART(YEAR, A.DATE) AS YEAR,
		COUNT(A.ENCOUNTER) AS NUMBEROFIMMUNIZATIONS
	FROM IMMUNIZATIONSDATA A
		JOIN PATIENTSDATA B 
		ON A.PATIENT=B.ID
	GROUP BY 
		DATEPART(YEAR, A.DATE) )X
ORDER BY NUMBEROFIMMUNIZATIONS DESC;

