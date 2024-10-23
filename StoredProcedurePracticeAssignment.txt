/**********************************************************************************************************************
DEVELOPER: JOHN O. UMUKORO
DATE CREATED: 2024-10-18
CODE VERSION: 1.0
DESCRIPTION: THIS CODE SHOWS HOW TO CREATE SIMPLE AND PARAMETERIZED STORED PROCEDURE

**********************************************************************************************************************/

--To create new stored procedure spEmadeConsultingEmployee
CREATE PROCEDURE spEmadeConsultingEmployee
AS 
SELECT *
FROM EMADECONSULTINGEMPLOYEE

EXEC spEmadeConsultingEmployee

--To create parameterized stored procedure EmadeConsultingEmployee by ID
CREATE PROCEDURE spEmadeConsultingEmployeeID
@EMPLOYEE_ID INT 
AS 
BEGIN
SELECT *
FROM EMADECONSULTINGEMPLOYEE
WHERE EMPLOYEE_ID=@EMPLOYEE_ID
END

--To execute newly created stored procedure
EXEC spEmadeConsultingEmployeeID @Employee_ID=7369

--To create parameterized stored procedure EmadeConsultingEmployee by JobID
CREATE PROCEDURE spEmadeConsultingEmployeeJobID
@JOBID INT
AS
BEGIN
SELECT *
FROM EMADECONSULTINGEMPLOYEE
WHERE JOB_ID=@JOBID
END

--To execute stored procedure
EXEC spEmadeConsultingEmployeeJobID @JobID=671

--To create parameterized stored procedure EmadeConsultingDepartment by DepartmentID and Name
CREATE PROCEDURE spEmadeConsultingDepartment
@DEPTID INT,
@NAME VARCHAR(50)
AS
BEGIN
SELECT *
FROM EMADECONSULTINGDEPARTMENT
WHERE @DEPTID=DEPARTMENT_ID
AND @NAME=NAME
END

--To execute stored procedure
EXEC spEmadeConsultingDepartment @DeptID=30, @Name='Research'


