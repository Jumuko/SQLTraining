
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
ORDER BY CITY DESC;

--save into view
create view vwNoOfPatientsByCity
as
SELECT DISTINCT 
	CITY, 
	COUNT(ID) AS P
FROM PATIENTSDATA
--WHERE CITY <> 'QUINCY'
GROUP BY CITY
HAVING COUNT(ID) > 1
--ORDER BY CITY DESC

select *
from vwNoOfPatientsByCity

--QUESTION 2: find out the patients with the highest number of visits
WITH VISITS AS
		(
	SELECT DISTINCT 
		B.CITY,
		A.PATIENT,
		B.ID,
		B.FIRST,
		COUNT(B.ID) AS NUMBEROFVISITS
	FROM ENCOUNTERSDATA A
		JOIN PATIENTSDATA B 
		ON A.PATIENT=B.ID
	GROUP BY B.CITY,A.PATIENT,B.ID,B.FIRST
		)

SELECT *
FROM VISITS
WHERE NUMBEROFVISITS =
	(
	SELECT 
	MAX(NUMBEROFVISITS) AS MAXVISITS
	FROM VISITS
	);
--save into view
create view 
vwMostVisitPatient1 as
	WITH VISITS AS
		(
	SELECT DISTINCT 
		B.CITY,
		B.FIRST,
		B.LAST,
		B.ID,
		A.PATIENT,
		COUNT(B.ID) AS NUMBEROFVISITS,
		substring(B.last, 1,1) LASTINITIAL
	FROM ENCOUNTERSDATA A
		JOIN PATIENTSDATA B 
		ON A.PATIENT=B.ID
	GROUP BY B.CITY,B.FIRST,B.LAST,B.ID,A.PATIENT
		)

SELECT FIRST,
LASTINITIAL,
NUMBEROFVISITS
FROM VISITS
WHERE NUMBEROFVISITS =
	(
	SELECT 
	MAX(NUMBEROFVISITS) AS MAXVISITS
	FROM VISITS
	);

--check view
select *
from vwMostVisitPatient

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

--save as view
create view vwTop10MostVisitPatients as
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

--check view
select *
from vwTop10MostVisitPatients

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
--save into view
create view vwNoOfPatientVisitsByCity as
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
--ORDER BY NUMBEROFVISITS DESC;

--check view
select *
from vwNoOfPatientVisitsByCity

--QUESTION 5: ⁠To find out the cities with up to 10 counts of emergency cases.
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
HAVING COUNT(ENCOUNTERCLASS) >= 10
ORDER BY COUNTSOFEMERGENCYCASES DESC
;⁠
--save into view
create view vwCityWith10CountsOfEmergencyCases as
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
HAVING COUNT(ENCOUNTERCLASS) >= 10
--ORDER BY COUNTSOFEMERGENCYCASES DESC
--Check view
select *
from vwCityWith10CountsOfEmergencyCases

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
--save into view
create view vwNoOfBostonPatientVisitIn2020 as
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

--check view
select *
from vwNoOfBostonPatientVisitIn2020

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
 --save into view
 create view vwTopRecurringConditions as
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
--ORDER BY NUMBEROFRECURRENCE DESC;
--check view
select *
from vwTopRecurringConditions

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
--save into view
create view vwMonthWithHighestNumberOfAmbulatorySince2010 as
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
 --ORDER BY NUMBEROFAMBULATORYCASES DESC
--check view
select *
from vwMonthWithHighestNumberOfAmbulatorySince2010

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
--save into view
create view vwMonthWithHighestNumberOfEmergencySince2010 as
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

--check view
select *
from vwMonthWithHighestNumberOfEmergencySince2010

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
--save into view
create view vwTop15YearsWithTheMostImmunization as
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
--check view
select *
from vwTop15YearsWithTheMostImmunization
/**
Patient Demographics:

Breakdown of patients by age, gender, and ethnicity.
Geographic distribution of patients (where they are coming from).
Encounter Types:

Number of patient encounters by type (e.g., inpatient, outpatient, emergency).
Trends over time for each encounter type (daily, weekly, monthly).
Admission and Discharge Metrics:

Average length of stay (LOS) per department.
Time from admission to discharge.
Discharge dispositions (e.g., home, transferred, deceased).
Department Utilization:

Patient volume by department (e.g., cardiology, pediatrics, ER).
Bed occupancy rates and availability by department.
Trends in department utilization over time.
Common Diagnoses and Procedures:

Top diagnoses and procedures performed.
Trends in certain diagnoses (e.g., seasonal illnesses, chronic conditions).
Readmission Rates:

Percentage of patients readmitted within 30 days.
Readmission rates by department or diagnosis.
Patient Outcomes:

Patient satisfaction scores (if available).
Mortality and complication rates by department or procedure.
Wait Times:

Average time to be seen by a provider (in emergency or outpatient settings).
Trends in wait times over time and by department.
Financial Metrics:

Revenue generated per patient encounter.
Cost of care per patient and per department.
Payer mix (e.g., Medicare, Medicaid, private insurance, self-pay).
Resource Utilization:

Utilization of resources such as medications, imaging, and labs.
Average number of tests or procedures ordered per patient encounter.
Patient Flow and Bottlenecks:
Time spent in different stages of the patient journey (e.g., registration, triage, consultation, discharge).
Identification of bottlenecks in the patient flow process.
Provider Performance:
Number of patients seen per provider.
Average encounter time per provider.
Outcomes and satisfaction metrics linked to specific providers.
**/

select *
from ConditionsData

select*
from MedicationsData

--Reports
--QUESTION 6: ⁠Now to find out the number of patients from Boston who came in 2020
--Number of patient encounters by type (e.g., inpatient, outpatient, emergency).
--Trends over time for each encounter type (daily, weekly, monthly)

--QUESTION 1: Lists out number of patients in descending order,Does not include city Quincy,
--			  Must have at least 2 patients from that city

select distinct CITY,
count(ID) as NumberOfPatients
from PatientsData
where City<>'Quincy'
group by CITY
having count(ID) > 1
order by NumberOfPatients desc

