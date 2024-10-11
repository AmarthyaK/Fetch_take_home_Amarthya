-- How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?

USE FETCH_DB_Amarthya;
-- Please comment and uncomment the recent_month variable accordingly

-- SET @MOST_RECENT_MONTH = (SELECT DATE_FORMAT(MAX(scanned_date_time), '%Y-%m-01') FROM receipts);

-- Since there are only 2 Distinct brands for the most recent months, it is worthwhile to check out previous months as well

-- SET @MOST_RECENT_MONTH = '2021-02-01';

SET @MOST_RECENT_MONTH = '2021-01-01';

WITH CURRENT_RANK_TABLE AS (
    SELECT RR.brandCode AS Brand,
    SUM(IF(
    DATE_FORMAT(R.scanned_date_time,'%Y%m') = DATE_FORMAT(@MOST_RECENT_MONTH,'%Y%m'),1,0
    )) AS Current_Month_ReceiptsCount,
    SUM(IF(
    DATE_FORMAT(R.scanned_date_time, '%Y%m') = DATE_FORMAT(DATE_SUB(@MOST_RECENT_MONTH, INTERVAL 1 MONTH), '%Y%m'), 1, 0
    )) AS Previous_Month_ReceiptsCount,
    
    -- Apply DENSE_RANK() for Current Month Count
    DENSE_RANK() OVER 
    (ORDER BY SUM(IF(DATE_FORMAT(R.scanned_date_time,'%Y%m') = DATE_FORMAT(@MOST_RECENT_MONTH,'%Y%m'), 1, 0)) DESC)
    AS Current_Brand_Rank,

    -- Apply DENSE_RANK() for Previous Month Count
    DENSE_RANK() OVER 
    (ORDER BY SUM(IF(DATE_FORMAT(R.scanned_date_time, '%Y%m') = DATE_FORMAT(DATE_SUB(@MOST_RECENT_MONTH, INTERVAL 1 MONTH), '%Y%m'), 1, 0)) DESC)
    AS Previous_Brand_Rank

    FROM rewards_receipts RR
    INNER JOIN receipts R
    ON RR.receipt_id = R.receipt_id
    WHERE RR.brandCode IS NOT NULL AND RR.brandCode != 'ITEM'
    GROUP BY Brand
)
SELECT Brand, 
Current_Month_ReceiptsCount, 
Previous_Month_ReceiptsCount, 
Current_Brand_Rank, 
Previous_Brand_Rank, 
CAST(Previous_Brand_Rank AS SIGNED) - CAST(Current_Brand_Rank AS SIGNED) Rank_Difference
FROM CURRENT_RANK_TABLE
WHERE Current_Brand_Rank <= 5 AND Current_Month_ReceiptsCount!= 0
ORDER BY Current_Brand_Rank ASC;
