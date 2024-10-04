use Test
go
;

drop table if exists CarePlansData
create table CarePlansData
(
Id varchar (250) not null, 
[START] varchar (250) null, 
[STOP] Varchar (250) null, 
PATIENT varchar (250) not null,
ENCOUNTER varchar (250) not null,
CODE varchar (250) null,
[DESCRIPTION] varchar (250) null, 
REASONCODE varchar (250) null,
REASONDESCRIPTION varchar(250) null
)

drop table if exists AllergiesData
create table AllergiesData
(
START varchar(250) null,	
STOP varchar(250) null,	
PATIENT varchar(250) not null,	
ENCOUNTER varchar(250) not null,	
CODE varchar(250) null,	
SYSTEM varchar(250) null,	
DESCRIPTION varchar(250) null,	
TYPE varchar(250) null,	
CATEGORY varchar(250) null,	
REACTION1 varchar(250) null,	
DESCRIPTION1 varchar(250) null,	
SEVERITY1 varchar(250) null,	
REACTION2 varchar(250) null,	
DESCRIPTION2 varchar(250) null,	
SEVERITY2 varchar(250) null
)


drop table if exists ClaimsData
create table ClaimsData
(Id varchar(250) not null,	
PATIENTID varchar(250) not null Primary Key,	
PROVIDERID varchar(250) not null,	
PRIMARYPATIENTINSURANCEID varchar(250) not null,	
SECONDARYPATIENTINSURANCEID varchar(250) not null,	
DEPARTMENTID varchar(250) not null,
PATIENTDEPARTMENTID varchar(250) not null,	
DIAGNOSIS1 varchar(250) null,	
DIAGNOSIS2 varchar(250) null,	
DIAGNOSIS3 varchar(250) null,	
DIAGNOSIS4 varchar(250) null,	
DIAGNOSIS5 varchar(250) null,	
DIAGNOSIS6 varchar(250) null,	
DIAGNOSIS7 varchar(250) null,	
DIAGNOSIS8 varchar(250) null,	
REFERRINGPROVIDERID varchar(250) not null,	
APPOINTMENTID varchar(250) not null,	
CURRENTILLNESSDATE varchar(250) null,	
SERVICEDATE varchar(250) null,	
SUPERVISINGPROVIDERID varchar(250) null,	
STATUS1 varchar(250) null,	
STATUS2 varchar(250) null,	
STATUSP varchar(250) null,	
OUTSTANDING1 varchar(250) null,	
OUTSTANDING2 varchar(250) null,	
OUTSTANDINGP varchar(250) null,	
LASTBILLEDDATE1 varchar(250) null,	
LASTBILLEDDATE2 varchar(250) null,	
LASTBILLEDDATEP varchar(250) null,	
HEALTHCARECLAIMTYPEID1 varchar(250) not null,	
HEALTHCARECLAIMTYPEID2 varchar(250) not null,
)

drop table if exists Claims_TransactionsData
create table Claims_TransactionsData
(ID varchar(250) not null,	
CLAIMID varchar(250) not null,	
CHARGEID varchar(250) not null,	
PATIENTID varchar(250) not null,	
TYPE varchar(250) null,	
AMOUNT varchar(250) null,	
METHOD varchar(250) null,	
FROMDATE varchar(250) null,	
TODATE varchar(250) null,	
PLACEOFSERVICE varchar(250) null,
PROCEDURECODE varchar(250) null,	
MODIFIER1 varchar(250) null,	
MODIFIER2 varchar(250) null,	
DIAGNOSISREF1 varchar(250) null,	
DIAGNOSISREF2 varchar(250) null,	
DIAGNOSISREF3 varchar(250) null,	
DIAGNOSISREF4 varchar(250) null,	
UNITS varchar(250) null,	
DEPARTMENTID varchar(250) not null,	
NOTES varchar(250) null,	
UNITAMOUNT varchar(250) null,	
TRANSFEROUTID varchar(250) not null,	
TRANSFERTYPE varchar(250) null,	
PAYMENTS varchar(250) null,	
ADJUSTMENTS varchar(250) null,	
TRANSFERS varchar(250) null,	
OUTSTANDING varchar(250) null,	
APPOINTMENTID varchar(250) not null,	
LINENOTE varchar(250) null,	
PATIENTINSURANCEID varchar(250) not null,	
FEESCHEDULEID varchar(250) not null,	
PROVIDERID varchar(250) not null,	
SUPERVISINGPROVIDERID varchar(250) not null
)

drop table if exists ConditionsData
create table ConditionsData
(
START varchar(250) null,	
STOP varchar(250) null,	
PATIENT varchar(250) not null,
ENCOUNTER varchar(250) not null,	
SYSTEM varchar(250) null,	
CODE varchar(250) null,	
DESCRIPTION varchar(250) null
)

drop table if exists DevicesData
create table DevicesData
(
START varchar(250) null,
STOP varchar(250) null,	
PATIENT varchar(250) not null,	
ENCOUNTER varchar(250) not null,	
CODE varchar(250) null,	
DESCRIPTION varchar(250) null,	
UDI varchar(250) null
)

drop table if exists EncountersData
create table EncountersData
(
Id varchar(250) not null,	
START varchar(250) null,	
STOP varchar(250) null,	
PATIENT varchar(250) not null,	
ORGANIZATION varchar(250) not null,	
PROVIDER varchar(250) not null,	
PAYER varchar(250) not null,	
ENCOUNTERCLASS varchar(250) null,	
CODE varchar(250) null,	
DESCRIPTION varchar(250) null,	
BASE_ENCOUNTER_COST varchar(250) null,	
TOTAL_CLAIM_COST varchar(250) null,	
PAYER_COVERAGE varchar(250) null,	
REASONCODE varchar(250) null,	
REASONDESCRIPTION varchar(250) null
)

drop table if exists Imaging_StudiesData
create table Imaging_StudiesData
(
Id varchar(250) not null,	
DATE varchar(250) null,	
PATIENT varchar(250) not null,
ENCOUNTER varchar(250) not null,	
SERIES_UID varchar(250) null,	
BODYSITE_CODE varchar(250) null,	
BODYSITE_DESCRIPTION varchar(250) null,	
MODALITY_CODE varchar(250) null,	
MODALITY_DESCRIPTION varchar(250) null,	
INSTANCE_UID varchar(250) null,	
SOP_CODE varchar(250) null,	
SOP_DESCRIPTION varchar(250) null,	
PROCEDURE_CODE varchar(250) null
)

drop table if exists ImmunizationsData
create table ImmunizationsData
(
DATE varchar(250) null,	
PATIENT varchar(250) not null,
ENCOUNTER varchar(250) not null,	
CODE varchar(250) null,	
DESCRIPTION varchar(250) null,	
BASE_COST varchar(250) null
)

drop table if exists MedicationsData
create table MedicationsData
(
START varchar(250) null,	
STOP varchar(250) null,	
PATIENT varchar(250) not null,	
PAYER varchar(250) not null,	
ENCOUNTER varchar(250) not null,	
CODE varchar(250) null,	
DESCRIPTION varchar(250) null,	
BASE_COST varchar(250) null,	
PAYER_COVERAGE varchar(250) null,	
DISPENSES varchar(250) null,	
TOTALCOST varchar(250) null,	
REASONCODE varchar(250) null,	
REASONDESCRIPTION varchar(250) null
)


drop table if exists ObservationsData
create table ObservationsData
(
DATE varchar(250) null,	
PATIENT varchar(250) not null,	
ENCOUNTER varchar(250) not null,	
CATEGORY varchar(250) null,	
CODE varchar(250) null,	
DESCRIPTION varchar(250) null,	
VALUE varchar(250) null,	
UNITS varchar(250) null,	
TYPE varchar(250) null
)

drop table if exists OrganizationsData
create table OrganizationsData
(
Id varchar(250) not null,	
NAME varchar(250) not null,	
ADDRESS varchar(250) null,	
CITY varchar(250) null,	
STATE varchar(250) null,	
ZIP varchar(250) null,	
LAT varchar(250) null,	
LON varchar(250) null,	
PHONE varchar(250) null,	
REVENUE varchar(250) null,	
UTILIZATION varchar(250) null
)


drop table if exists PatientsData
create table PatientsData
(
Id varchar(250) not null,	
BIRTHDATE varchar(250) null,	
DEATHDATE varchar(250) null,	
SSN varchar(250) null,
DRIVERS varchar(250) null,	
PASSPORT varchar(250) null,	
PREFIX varchar(250) null,	
FIRST varchar(250) null,	
MIDDLE varchar(250) null,	
LAST varchar(250) null,	
SUFFIX varchar(250) null,	
MAIDEN varchar(250) null,	
MARITAL varchar(250) null,	
RACE varchar(250) null,	
ETHNICITY varchar(250) null,	
GENDER varchar(250) null,	
BIRTHPLACE varchar(250) null,	
ADDRESS varchar(250) null,	
CITY varchar(250) null,	
STATE varchar(250) null,	
COUNTY varchar(250) null,	
FIPS varchar(250) null,	
ZIP varchar(250) null,	
LAT varchar(250) null,	
LON varchar(250) null,	
HEALTHCARE_EXPENSES varchar(250) null,	
HEALTHCARE_COVERAGE varchar(250) null,	
INCOME varchar(250) null
)

drop table if exists Payer_TransitionsData
create table Payer_TransitionsData
(
PATIENT varchar(250) not null,	
MEMBERID varchar(250) not null,	
START_DATE varchar(250) null,	
END_DATE varchar(250) null,	
PAYER varchar(250) not null,	
SECONDARY_PAYER varchar(250) null,	
PLAN_OWNERSHIP varchar(250) null,	
OWNER_NAME varchar(250) null
)

drop table if exists PayersData
create table PayersData
(
Id varchar(250) not null,	
NAME varchar(250) null,	
OWNERSHIP varchar(250) null,	
ADDRESS varchar(250) null,	
CITY varchar(250) null,	
STATE_HEADQUARTERED varchar(250) null,	
ZIP varchar(250) null,	
PHONE varchar(250) null,	
AMOUNT_COVERED varchar(250) null,	
AMOUNT_UNCOVERED varchar(250) null,	
REVENUE varchar(250) null,	
COVERED_ENCOUNTERS varchar(250) null,	
UNCOVERED_ENCOUNTERS varchar(250) null,	
COVERED_MEDICATIONS varchar(250) null,	
UNCOVERED_MEDICATIONS varchar(250) null,	
COVERED_PROCEDURES varchar(250) null,	
UNCOVERED_PROCEDURES varchar(250) null,	
COVERED_IMMUNIZATIONS varchar(250) null,	
UNCOVERED_IMMUNIZATIONS varchar(250) null,	
UNIQUE_CUSTOMERS varchar(250) null,	
QOLS_AVG varchar(250) null,	
MEMBER_MONTHS varchar(250) null
)

drop table if exists ProceduresData
create table ProceduresData
(
START varchar(250) null,	
STOP varchar(250) null,	
PATIENT varchar(250) not null,	
ENCOUNTER varchar(250) not null,
SYSTEM varchar(250) null,	
CODE varchar(250) null,	
DESCRIPTION varchar(250) null,	
BASE_COST varchar(250) null,	
REASONCODE varchar(250) null,	
REASONDESCRIPTION varchar(250) null
)

drop table if exists ProvidersData
create table ProvidersData
(
Id varchar(250) not null,	
ORGANIZATION varchar(250) not null,	
NAME varchar(250) null,
GENDER varchar(250) null,	
SPECIALITY varchar(250) null,	
ADDRESS varchar(250) null,	
CITY varchar(250) null,	
STATE varchar(250) null,
ZIP varchar(250) null,	
LAT varchar(250) null,	
LON varchar(250) null,	
ENCOUNTERS varchar(250) not null,	
PROCEDURES varchar(250) not null
)

drop table if exists SuppliesData
Create table SuppliesData
(
DATE varchar(250) null,	
PATIENT varchar(250) not null,	
ENCOUNTER varchar(250) not null,	
CODE varchar(250) null,	
DESCRIPTION varchar(250) null,	
QUANTITY varchar(250) null
)

bulk insert CarePlansData
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Patient Project\careplans.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)


bulk insert AllergiesData
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Patient Project\allergies.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)

select *
from AllergiesData

bulk insert ClaimsData
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Patient Project\claims.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)

bulk insert Claims_TransactionsData
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Patient Project\claims_transactions.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)

bulk insert ConditionsData
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Patient Project\conditions.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)

bulk insert DevicesData
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Patient Project\devices.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)

bulk insert EncountersData
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Patient Project\encounters.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)

bulk insert Imaging_StudiesData
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Patient Project\imaging_studies.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)

bulk insert [dbo].[ImmunizationsData]
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Patient Project\immunizations.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)

bulk insert MedicationsData
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Patient Project\medications.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)

bulk insert [dbo].[ObservationsData]
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Patient Project\observations.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)

bulk insert [dbo].[OrganizationsData]
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Patient Project\organizations.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)

bulk insert [dbo].[PatientsData]
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Patient Project\patients.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)

bulk insert [dbo].[Payer_TransitionsData]
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Patient Project\payer_transitions.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)

bulk insert [dbo].[PayersData]
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Patient Project\payers.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)

bulk insert [dbo].[ProceduresData]
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Patient Project\procedures.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)

bulk insert [dbo].[ProvidersData]
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Patient Project\providers.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)

bulk insert [dbo].[SuppliesData]
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Patient Project\supplies.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)
