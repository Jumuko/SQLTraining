/**********************************************************************************************************************
DEVELOPER: JOHN O. UMUKORO
DATE CREATED: 2024-10-3
CODE VERSION: 1.0
DESCRIPTION: THIS CODE PROVIDES SOLUTION FOR SQL TRAINING HOME ASSIGNMENT 

**********************************************************************************************************************/


-- Switch to SQLTraining Database/Environment
USE SQLTRAINING
GO

-- Check EmadeconsultingEmployee table
SELECT *
FROM EMADECONSULTINGEMPLOYEE

--QUESTION 1:Produce a report that shows the second highest salary
SELECT 
	NAME,
	OCCUPATION,
	WORKING_DATE,
	WORKING_HOURS,
	SALARY
FROM
	(
	SELECT *,
		DENSE_RANK() OVER (ORDER BY SALARY DESC) AS DRNK
	FROM EMADECONSULTINGEMPLOYEE
	) X
WHERE DRNK = 2

--QUESTION 2:Produce a report that shows the third least working hours
SELECT 
	NAME,
	OCCUPATION,
	WORKING_DATE,
	WORKING_HOURS,
	SALARY
FROM
	(
	SELECT *,
		DENSE_RANK() OVER (ORDER BY WORKING_HOURS DESC) AS DRNK
	FROM EMADECONSULTINGEMPLOYEE
	) X
WHERE DRNK = 3
;

--Check EmployeeInfo table
SELECT *
FROM EMPLOYEEINFO

--QUESTION 1:Produce a report that shows the fourth youngest employees
SELECT FIRST_NAME,LAST_NAME,EMPLOYEES
FROM
	(
	SELECT *,
		DENSE_RANK() OVER (ORDER BY EMPLOYEES ASC) AS DRNK
	FROM EMPLOYEEINFO
	) X
WHERE DRNK = 4
;

--Check HrAnalysis1 table
SELECT *
FROM HRANALYSIS1

--QUESTION 1:Produce a report that shows the third percentsalaryhike who had at least three training times last year.
SELECT *
FROM
	(
	SELECT *,
		DENSE_RANK() OVER (ORDER BY PERCENTSALARYHIKE DESC) AS DRNK
	FROM HRANALYSIS1
	) X
WHERE DRNK = 3
AND TRAININGTIMESLASTYEAR >= 3