-- When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?

USE FETCH_DB_Amarthya;

SELECT R.rewardsReceiptStatus As RewardStatus,
ROUND(SUM(COALESCE(R.purchasedItemCount,0)),4) AS Total_number_of_items_purchased
FROM receipts R
GROUP BY R.rewardsReceiptStatus
HAVING R.rewardsReceiptStatus = 'FINISHED' or R.rewardsReceiptStatus = 'REJECTED'
ORDER BY Total_number_of_items_purchased DESC;
