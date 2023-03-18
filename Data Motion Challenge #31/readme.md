Question 1

CVS Health is trying to better understand its pharmacy sales, and how well different products are selling. Each drug can only be produced by one manufacturer.
Write a query to find the top 3 most profitable drugs sold, and how much profit they made. Assume that there are no ties in the profits. Display the result from the highest to the lowest total profit.

Definition:
cogs stands for Cost of Goods Sold which is the direct cost associated with producing the drug.
Total Profit = Total Sales - Cost of Goods Sold

If you like this question, try out Pharmacy Analytics (Part 2)!
pharmacy_sales Table:

![Screenshot 2023-03-18 185923](https://user-images.githubusercontent.com/22597020/226130507-d13fabb4-8858-4c1c-9771-72b3117703fa.jpg)

  Insight: Humira made the most profit (of $81,515,652.55) followed by Keytruda (of $11,622,022.02) and Dupixent (of $11,217,052.34).


Question 2

Write a query to find out which manufacturer is associated with the drugs that were not profitable and how much money CVS lost on these drugs. 
Output the manufacturer, number of drugs and total losses. Total losses should be in absolute value. Display the results with the highest losses on top.	
	
Question 3

Write a query to find the total sales of drugs for each manufacturer. Round your answer to the closest million, and report your results in descending order of total sales.Because this data is being directly fed into a dashboard which is being seen by business stakeholders, format your result like this: "$36 million".


![JOINS](https://user-images.githubusercontent.com/22597020/226130261-340ffd21-9daf-468d-adc3-32320bab6e3a.png)
