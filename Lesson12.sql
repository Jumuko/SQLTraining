--Analytical function
 WITH YOUNGEST_3RD AS 
     (
  SELECT
        A.NAME, 
		B.USG_TYP, 
		B.PHONE_NBR,
		A.AGE,
       ROW_NUMBER() OVER (ORDER BY AGE DESC) AS RN,
		RANK() OVER (ORDER BY AGE DESC) AS RNK,
		DENSE_RANK() OVER (ORDER BY AGE DESC) AS DRNK
    FROM   PRSN AS A
    LEFT JOIN PRSN_PHN AS B
    ON A.PRSN_IK = B.PRSN_IK
    LEFT JOIN PRSN_ADDR AS C
    ON C.PRSN_IK = A.PRSN_IK 
)
--SELECT ONLY REQUESTED FIELDS FOR OUTPUT
SELECT   
	NAME, 
	USG_TYP, 
	PHONE_NBR 
FROM YOUNGEST_3RD
WHERE RNK = 3;

--Partition
SELECT
        A.NAME, 
		B.USG_TYP, 
		B.PHONE_NBR,
		A.AGE,
       ROW_NUMBER() OVER (ORDER BY AGE DESC) AS RN,
		RANK() OVER ( Partition by AGE ORDER BY AGE DESC) AS RNK,
		DENSE_RANK() OVER (partition by AGE ORDER BY AGE DESC) AS DRNK
    FROM   PRSN AS A
    LEFT JOIN PRSN_PHN AS B
    ON A.PRSN_IK = B.PRSN_IK
    LEFT JOIN PRSN_ADDR AS C
    ON C.PRSN_IK = A.PRSN_IK 
