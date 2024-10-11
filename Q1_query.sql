-- What are the top 5 brands by receipts scanned for most recent month?

USE FETCH_DB_Amarthya;

-- Please comment and uncomment the recent_month variable accordingly

SET @MOST_RECENT_MONTH = (SELECT DATE_FORMAT(MAX(scanned_date_time), '%Y-%m-01') FROM receipts);

-- Since there are only 2 Distinct brands for the most recent month, 
-- it is worthwhile to check out previous months as well

-- SET @MOST_RECENT_MONTH = '2021-02-01';

-- SET @MOST_RECENT_MONTH = '2021-01-01';

WITH COUNT_BRAND_RECEIPTS AS(
    SELECT RR.brandCode AS Brand,
    COUNT(RR.receipt_id) AS ReceiptCount,
    DENSE_RANK() OVER(ORDER BY COUNT(RR.receipt_id) DESC) AS BrandRank
    FROM rewards_receipts RR
    INNER JOIN receipts R
    ON RR.receipt_id = R.receipt_id
    WHERE DATE_FORMAT(R.scanned_date_time,'%Y%m') = DATE_FORMAT(@MOST_RECENT_MONTH, '%Y%m')
      AND RR.brandCode IS NOT NULL 
      AND RR.brandCode != 'ITEM'
    GROUP BY Brand
)

SELECT Brand, ReceiptCount, BrandRank
FROM COUNT_BRAND_RECEIPTS
WHERE BrandRank <= 5
ORDER BY BrandRank ASC;