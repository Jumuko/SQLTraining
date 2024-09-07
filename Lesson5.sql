--SubString,Upper,Lower,Left,Right,wildcard
select EmpID,EmpName,EmpSalary
from UniqueEmployeeInfo

--substring example
select EmpID,EmpName,
upper(SUBSTRING(EmpName,1,2)) as EmpNameSubstring,
EmpSalary
from UniqueEmployeeInfo

--upper example
select EmpID,EmpName,
upper(EmpName) as EmpNameUpper,
EmpSalary
from UniqueEmployeeInfo

--lower example
select EmpID,EmpName,
lower(EmpName) as EmpNamelower,
EmpSalary
from UniqueEmployeeInfo

--wildcard example
select EmpID,EmpName,
lower(EmpName) as EmpNamelower,
EmpSalary
from UniqueEmployeeInfo
where EmpName like '%s'

--similarly for empnames that starts with R
select EmpID,EmpName,
lower(EmpName) as EmpNamelower,
EmpSalary
from UniqueEmployeeInfo
where EmpName like 'r%'

--create a field named SubstringType consisting of the first 3 letters of movie type
select *,
substring(Type,1,3) as SubstringType
from Movies

--create a field named TypeCode consisting of the first 3 letters of movie type in UpperCase
select *,
upper(substring(Type,1,3)) as TypeCode
from Movies

