/* Analysis - paper 0:
Number of patients prescribed statins on the day or within 12 months 
of their completed health check 

SELECT TOP 10 * FROM [NHS_Health_Checks].[dbo].[EC_6_COHORT_PRESCRIPTIONS]
*/


/* All IT suppliers (minus TPP) */

SELECT
COALESCE(CVD_RISK_SCORE_CLASS, 'TOTAL') AS CVD_RISK_SCORE_CLASS 
,COUNT(PATIENT_JOIN_KEY) AS NO_ATTENDEES
,SUM(CASE WHEN PRESCRIPTION_DATE_DIFF IS NOT NULL THEN 1 ELSE 0 END) AS NO_STATINS
,SUM(CASE WHEN PRESCRIPTION_DATE_DIFF IS NOT NULL THEN 1 ELSE 0 END)*1.00/COUNT(PATIENT_JOIN_KEY) AS PC_PRESCRIBED

FROM [NHS_Health_Checks].[dbo].[EC_NHSHC_PAPER0_PATIENTS]

WHERE COHORT = 'ATTENDEE'
AND SUPPLIER_NAME <> 'TPP'

GROUP BY 
CVD_RISK_SCORE_CLASS 
WITH ROLLUP
ORDER BY 1



/* Analysis by IT supplier */
SELECT
COALESCE(SUPPLIER_NAME, 'TOTAL') AS SUPPLIER
,COALESCE(CVD_RISK_SCORE_CLASS, 'TOTAL') AS CVD_RISK_SCORE_CLASS 
,COUNT(PATIENT_JOIN_KEY) AS NO_ATTENDEES
,SUM(CASE WHEN PRESCRIPTION_DATE_DIFF IS NOT NULL THEN 1 ELSE 0 END) AS NO_STATINS
,SUM(CASE WHEN PRESCRIPTION_DATE_DIFF IS NOT NULL THEN 1 ELSE 0 END)*1.00/COUNT(PATIENT_JOIN_KEY) AS PC_PRESCRIBED

FROM [NHS_Health_Checks].[dbo].[EC_NHSHC_PAPER0_PATIENTS]

WHERE COHORT = 'ATTENDEE'
AND SUPPLIER_NAME <> 'TPP'
--AND SUPPLIER_NAME <> 'Unknown'

GROUP BY 
SUPPLIER_NAME 
,CVD_RISK_SCORE_CLASS 
WITH ROLLUP
ORDER BY 2,1
