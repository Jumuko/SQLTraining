USE TEST
;

DROP VIEW  if exists vwHospitalProjectData
go
create view vwHospitalProjectData1st as
select  Distinct 
		A.id PATIENT_ID,A.[BIRTHDATE], A.[DEATHDATE], A.[SSN], A.[DRIVERS], 
		A.[PASSPORT], A.[FIRST], A.[LAST], A.[MARITAL], A.[RACE], A.[ETHNICITY],
		A.[GENDER], A.[BIRTHPLACE], A.[ADDRESS], A.[CITY], A.[STATE], A.[COUNTY], 
		A.[FIPS], A.[LAT], A.[LON], A.[HEALTHCARE_EXPENSES], A.[HEALTHCARE_COVERAGE], 
		A.[INCOME],B.BASE_ENCOUNTER_COST,B.DESCRIPTION,B.ENCOUNTERCLASS,B.ID ENCOUNTER_ID,
		B.PAYER_COVERAGE,B.REASONCODE,B.REASONDESCRIPTION,B.START,B.STOP,
		B.TOTAL_CLAIM_COST,C.[START] ASTART, C.[STOP] ASTOP, C.[CODE] ALLERGY_CODE, C.[SYSTEM], 
		C.[DESCRIPTION] CLAIM_DESCRIPTION, C.[TYPE], C.[CATEGORY], C.[REACTION1], C.[DESCRIPTION1], C.[SEVERITY1], 
		D.[Id] CAREPLANS_ID, D.[START] CAREPLANS_START, D.[STOP] CAREPLANS_STOP, 
		D.[CODE] CAREPLANS_CODE, D.[DESCRIPTION] CAREPLANS_DESCRIPTION, D.[REASONCODE] CAREPLANS_REASONCODE, 
		D.[REASONDESCRIPTION] CAREPLANS_REASONDESCRIPTION
from PatientsData A
left join EncountersData B
on A.id=B.Patient
left join AllergiesData C
on A.id=C.Patient
left join CarePlansData D
on A.id=D.Patient
left join claimsData E
on A.id=E.PatientID
left join claimstransactiondata F
on A.id=F.PatientID
left join ConditionsData G
on A.id=G.Patient
left join ImagingStudiesData I
on A.id=I.Patient
left join ImmunizationsData J
on A.id=J.Patient
left join MedicationsData K
on A.id=K.Patient
left join ObservationsData L
on A.id=L.Patient
left join ProceduresData M
on A.id=M.Patient
left join Supplies N
on A.id=N.Patient
left join OrganizationsData O
on B.Organization=O.id
join providersData P
on B.Provider=P.id
left join DevicesData Q
on A.id=Q.Patient
left join PayertransitionsData R
on A.id=R.Patient
left join PayersData S 
on R.payer=S.id




create view vwHospitalProjectData2nd as
select  Distinct 
		E.[Id] CLAIMS_ID,
		E.[DIAGNOSIS1], E.[DIAGNOSIS2], E.[DIAGNOSIS3], E.[DIAGNOSIS4], 
		[DIAGNOSIS5], [DIAGNOSIS6], [DIAGNOSIS7], [DIAGNOSIS8], [REFERRINGPROVIDERID], 
		E.[CURRENTILLNESSDATE], E.[SERVICEDATE], E.[STATUS1], E.[STATUS2], E.[STATUSP], E.[OUTSTANDING1], E.[OUTSTANDING2], 
		E.[OUTSTANDINGP], E.[LASTBILLEDDATE1], E.[LASTBILLEDDATE2], E.[LASTBILLEDDATEP], E.[HEALTHCARECLAIMTYPEID1],
		E.[HEALTHCARECLAIMTYPEID2],F.[ID] CLAIMSTRANSACTION_ID, F.[TYPE] CLAIMSTRAN_TYPE, F.[AMOUNT], F.[METHOD], F.[FROMDATE], 
		F.[TODATE], F.[PLACEOFSERVICE], F.[PROCEDURECODE], F.[MODIFIER1], F.[MODIFIER2], F.[DIAGNOSISREF1], F.[DIAGNOSISREF2], 
		F.[DIAGNOSISREF3], F.[DIAGNOSISREF4], F.[UNITS], F.[NOTES], F.[UNITAMOUNT], F.[TRANSFERTYPE], F.[PAYMENTS], F.[ADJUSTMENTS], 
		F.[TRANSFERS], F.[OUTSTANDING], F.[LINENOTE], G.[START] CONDITIONS_START, G.[STOP] CONDITIONS_STOP, G.[ENCOUNTER] CONDITIONS_ENCOUNTER, 
		G.[SYSTEM] CONDITIONS_SYSTEM, G.[CODE] CONDITIONS_CODE, G.[DESCRIPTION] CONDITIONS_DESCRIPTION,I.[Id] IMG_ID, I.[DATE] IMG_DATE, I.[SERIES_UID], I.[BODYSITE_CODE], I.[BODYSITE_DESCRIPTION], I.[MODALITY_CODE], I.[MODALITY_DESCRIPTION], 
		I.[INSTANCE_UID], I.[SOP_CODE], I.[SOP_DESCRIPTION], I.[PROCEDURE_CODE], J.[DATE] IMM_DATE, J.[CODE] IMM_CODE, 
		J.[DESCRIPTION] IMM_DESCRIPTION,J.[BASE_COST], K.[START] MED_START, K.[STOP] MED_STOP, K.[CODE] MED_CODE,
		K.[DESCRIPTION] MED_DESCRIPTION, K.[BASE_COST] MED_BASECOST, K.[PAYER_COVERAGE] MED_PAYERCOVERAGE, K.[DISPENSES], K.[TOTALCOST], K.[REASONCODE] MED_REASONCODE, 
		K.[REASONDESCRIPTION] MED_REASONDESCRIPTION
from PatientsData A
left join EncountersData B
on A.id=B.Patient
left join AllergiesData C
on A.id=C.Patient
left join CarePlansData D
on A.id=D.Patient
left join claimsData E
on A.id=E.PatientID
left join claimstransactiondata F
on A.id=F.PatientID
left join ConditionsData G
on A.id=G.Patient
left join ImagingStudiesData I
on A.id=I.Patient
left join ImmunizationsData J
on A.id=J.Patient
left join MedicationsData K
on A.id=K.Patient
left join ObservationsData L
on A.id=L.Patient
left join ProceduresData M
on A.id=M.Patient
left join Supplies N
on A.id=N.Patient
left join OrganizationsData O
on B.Organization=O.id
join providersData P
on B.Provider=P.id
left join DevicesData Q
on A.id=Q.Patient
left join PayertransitionsData R
on A.id=R.Patient
left join PayersData S 
on R.payer=S.id



create view vwHospitalProjectData3rd as
select  Distinct 
		L.[DATE] OBSV_DATE, L.[ENCOUNTER] OBSV_ENCOUNTER, L.[CATEGORY] OBSV_CATEGORY, L.[CODE] OBSV_CODE, 
		L.[DESCRIPTION] OBSV_DESCRIPTION, L.[VALUE] OBSV_VALUE, L.[UNITS] OBSV_UNITS, L.[TYPE] OBSV_TYPE,M.[START] PRCD_START, M.[STOP] PRCD_STOP,M.[SYSTEM] PRCD_SYSTEM, M.[CODE] PRCD_CODE, M.[DESCRIPTION] PRCD_DESCRIPTION, M.[BASE_COST] PRCD_BASECOST, 
		M.[REASONCODE] PRCD_REASONCODE, M.[REASONDESCRIPTION] PRCD_REASONDESCRIPTION, N.[DATE] SUP_DATE, N.[CODE] SUP_CODE, 
		N.[DESCRIPTION] SUP_DESCRIPTION, N.[QUANTITY] SUP_QUANTITY,O.[Id] ORG_ID, O.[NAME] ORG_NAME, O.[ADDRESS] ORG_ADDRESS, O.[CITY] ORG_CITY, 
		O.[STATE] ORG_STATE, O.[ZIP] ORG_ZIP, O.[LAT] ORG_LAT, O.[LON] ORG_LON, O.[PHONE] ORG_PHONE, 
		O.[REVENUE] ORG_REVENUE, O.[UTILIZATION] ORG_UTILIZATION, P.[Id] PRVD_ID, P.[NAME] PRVD_NAME, P.[GENDER] PRVD_GENDER, 
		P.[SPECIALITY] PRVD_SPECIALITY, P.[ADDRESS] PRVD_ADDRESS, P.[CITY] PRVD_CITY, P.[STATE] PRVD_STATE, Q.[START] DEV_START, Q.[STOP] DEV_STOP, 
		Q.[CODE] DEV_CODE, Q.[DESCRIPTION] DEV_DESCRIPTION, Q.[UDI] DEV_UDI, R.[START_DATE], 
		R.[END_DATE], R.[SECONDARY_PAYER], R.[PLAN_OWNERSHIP], R.[OWNER_NAME],S.[Id], S.[NAME], S.[OWNERSHIP], S.[ADDRESS] PAYERS_ADDRESS, S.[CITY] PAYERS_CITY, 
		S.[STATE_HEADQUARTERED], S.[ZIP], S.[PHONE], S.[AMOUNT_COVERED], S.[AMOUNT_UNCOVERED], S.[REVENUE], S.[COVERED_ENCOUNTERS], 
		S.[UNCOVERED_ENCOUNTERS], S.[COVERED_MEDICATIONS], S.[UNCOVERED_MEDICATIONS], S.[COVERED_PROCEDURES], S.[UNCOVERED_PROCEDURES], 
		S.[COVERED_IMMUNIZATIONS], S.[UNCOVERED_IMMUNIZATIONS], S.[UNIQUE_CUSTOMERS], S.[QOLS_AVG], S.[MEMBER_MONTHS]
from PatientsData A
left join EncountersData B
on A.id=B.Patient
left join AllergiesData C
on A.id=C.Patient
left join CarePlansData D
on A.id=D.Patient
left join claimsData E
on A.id=E.PatientID
left join claimstransactiondata F
on A.id=F.PatientID
left join ConditionsData G
on A.id=G.Patient
left join ImagingStudiesData I
on A.id=I.Patient
left join ImmunizationsData J
on A.id=J.Patient
left join MedicationsData K
on A.id=K.Patient
left join ObservationsData L
on A.id=L.Patient
left join ProceduresData M
on A.id=M.Patient
left join Supplies N
on A.id=N.Patient
left join OrganizationsData O
on B.Organization=O.id
join providersData P
on B.Provider=P.id
left join DevicesData Q
on A.id=Q.Patient
left join PayertransitionsData R
on A.id=R.Patient
left join PayersData S 
on R.payer=S.id

select *
from vwHospitalProjectData3rd