-- When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?

USE FETCH_DB_Amarthya;

SELECT R.rewardsReceiptStatus As RewardStatus,
ROUND(AVG(COALESCE(R.totalSpent,0)),4) AS Avg_total_spent
FROM receipts R
GROUP BY R.rewardsReceiptStatus
HAVING R.rewardsReceiptStatus = 'FINISHED' or R.rewardsReceiptStatus = 'REJECTED'
ORDER BY Avg_total_spent DESC;
