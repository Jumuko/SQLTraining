/**********************************************************************************************************************
DEVELOPER: JOHN O. UMUKORO
DATE CREATED: 2024-10-16
CODE VERSION: 1.0
DESCRIPTION: THIS CODE CREATES A NEW DATABASE FOR PHARMACY, A TABLE TO SHOW RECORDS, UPDATE AND DELETE RECORDS

**********************************************************************************************************************/

CREATE TABLE EMADEPHARMACY
(ID INT NOT NULL, DRUGNAME VARCHAR(50) NULL, PRICE INT NOT NULL, LOCATION VARCHAR(50) NOT NULL)

INSERT INTO EMADEPHARMACY
VALUES
(1,'TYLENOL',50,'ELKGROVE'),
(2,'IBUPROFEN',70,'SAC'),
(3,'ADVIL',30,'ROSEVILLE')

UPDATE EMADEPHARMACY
SET PRICE=50
WHERE DRUGNAME = 'ADVIL'

UPDATE EMADEPHARMACY
SET LOCATION='ELKGROVE'
WHERE DRUGNAME = 'ADVIL'

BEGIN
TRANSACTION
DELETE FROM EMADEPHARMACY
WHERE LOCATION='ELKGROVE'
ROLLBACK


SELECT *
FROM EMADEPHARMACY

DROP TABLE IF EXISTS EMADEPHARMACYBKUP
SELECT *
INTO EMADEPHARMACYBKUP
FROM EMADEPHARMACY


SELECT *
FROM EMADEPHARMACYBKUP
UNION ALL
SELECT *
FROM EMADEPHARMACY

SELECT *
FROM EMADEPHARMACYBKUP
UNION 
SELECT *
FROM EMADEPHARMACY

SELECT *
FROM EMADEPHARMACYBKUP
INTERSECT
SELECT *
FROM EMADEPHARMACY

SELECT *
FROM EMADEPHARMACYBKUP
EXCEPT
SELECT *
FROM EMADEPHARMACY

INSERT INTO EMADEPHARMACY
VALUES
(4,'GABAPENTIN',50,'FLORIN'),
(5,'BACLOFEN',70,'POWERINN'),
(6,'NOCAL',30,'ROSEVILLE')

ALTER TABLE EMADEPHARMACY
ADD RATING VARCHAR(50)

UPDATE EMADEPHARMACY
SET RATING=
CASE
WHEN PRICE=70 THEN 'POOR'
WHEN PRICE=30 THEN 'EXCELLENT'
ELSE 'GREAT'
END
FROM EMADEPHARMACY;

CREATE PROCEDURE spEmadePharmacy 
as
select *
from EMADEPHARMACY

exec spEmadePharmacy

CREATE PROCEDURE spEmadePharmacyRating
@Rating varchar(50),

as
select *
from EMADEPHARMACY
where Rating=@Rating

exec spEmadePharmacyRating 'poor'

select *
from EmadeconsultingDEPARTMENT

drop table if exists StandardAlliance
create table StandardAlliance
([First Name] varchar(50) not null,
[Last Name] varchar(50) not null,
[ID No] int not null,
Position varchar(50) null,
[Start Date] date null)

insert into StandardAlliance
values
('Russel','Smith',001,'Physician',null),
('Joyce', 'Juliet',003,'RN','2024/10/22'),
('Vera','Cruz',005,'RN','2022/8/15'),
('Eby','Fernandez',007,'Janitor','2023/7/23')

select *
from StandardAlliance

update StandardAlliance
set [Start Date] = 2024-13-24
where [First Name]='Russel'

create procedure spStandardAlliance
as
begin
select *
from StandardAlliance
end
go

alter procedure spStandardAlliance
@Position varchar(50),
@StartDate date
as
begin
select *
from StandardAlliance
where Position=@Position
and [Start Date]=@StartDate
end
go

exec spStandardAlliance @Position='RN',@StartDate='2024-10-22'