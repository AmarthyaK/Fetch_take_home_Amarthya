-- Which brand has the most transactions among users who were created within the past 6 months?

USE FETCH_DB_Amarthya;

SELECT RR.brandCode AS Brand, COUNT(*) AS total_transactions
FROM rewards_receipts RR
INNER JOIN receipts R
ON RR.receipt_id = R.receipt_id
INNER JOIN users U
ON R.userId = U.user_id
WHERE DATE_FORMAT(U.created_date_time,'%Y%m') <= (SELECT DATE_FORMAT(MAX(created_date_time),'%Y%m') FROM users)
AND DATE_FORMAT(U.created_date_time,'%Y%m') > (SELECT DATE_FORMAT(DATE_SUB(MAX(created_date_time), INTERVAL 6 MONTH), '%Y%m') FROM users)
GROUP BY RR.brandCode
ORDER BY total_transactions DESC
LIMIT 1;
