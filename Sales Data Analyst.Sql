create database sales;
use sales;
drop database sales;
create table if not exists Sales_data(
 Product_id int auto_increment primary key,
 Sale_Date date,
 Sales_Rep varchar(50),
 Region varchar(40),
 Sales_Amount decimal(10,2),
 Quantity_Sold int,
 Product_category varchar(50),
 Unit_Cost decimal(10,2),
 Unit_Price decimal(10,2),
 Customer_Type varchar(20),
 Discount decimal(5,2),
 Payment_Method varchar(50),
 Sales_Channel varchar(50),
 Region_and_Sales_Rep varchar(100)
 );
 
 #1. Retrieve all records from the sales dataset. 
select * from sales_data;
# 2. Display all unique product categories available in the dataset.
select distinct Product_Category from sales_data;
#3. Find all sales made by a specific Sales Representative (e.g., Alice). 
select * from sales_data where Sales_Rep="Alice";
#4. Get all transactions from the “North” region where the Sales_Amount is above 5000. 
select * from sales_data where Region="North" and Sales_Amount >5000;
#5. List all customers who paid via “Credit Card” and are ‘Returning’ customers. 
select * from sales_data where Payment_Method="Credit Card" and Customer_Type="Returning";
#6. Retrieve sales records between ‘2023-01-01’ and ‘2023-06-30’. 
select * from sales_data where Sale_Date BETWEEN'2023-01-01' AND '2023-06-30';
#7. Calculate the total Sales_Amount for each Region. 
select Region,SUM(Sales_Amount) as Total_sales from sales_data GROUP BY Region;
#8. Find the average Unit_Price and Unit_Cost by Product_Category. 
select Product_Category,AVG(Unit_Price) AS Average_Unit_Price, AVG(Unit_Cost) AS Average_Unit_Cost from sales_data Group by Product_Category;
#9. Determine the total number of units sold (Quantity_Sold) by each Sales_Rep. 
select Sales_Rep,SUM(Quantity_Sold) AS Total_Number_of_Units from sales_data Group by Sales_Rep;
#10. Identify the highest and lowest Sales_Amount in the dataset. 
select MAX(Sales_Amount) AS Highest_Sale, MIN(Sales_Amount) AS Lowest_Sale from sales_data;
#11. Find the total discount given across all transactions. 
Select SUM(Discount) AS Total_Discount from sales_data;
#12. Calculate the average Sales_Amount per month. 
#(Hint: Use MONTH(Sale_Date) or equivalent date function.) 
 select MONTH(Sale_Date) AS Month_Name,AVG(Sales_Amount) AS Avg_Sales_Amount from sales_data Group by Month(Sale_Date) Order by Month(Sale_Date);
#13. Show the total sales and total quantity sold per Product_Category and Region. 
select Product_Category,Region, Sum(Sales_Amount) as Total_Sales,Sum(Quantity_Sold) as Quantity_Sold from sales_data 
group by Product_Category,Region
order by Product_Category,Region;
# 14. Calculate profit for each transaction as
# Profit = (Unit_Price - Unit_Cost) * Quantity_Sold and display the top 10 most profitable transactions.
SELECT Product_ID, Sales_Rep, Region, Product_Category, (Unit_Price - Unit_Cost) * Quantity_Sold AS Profit FROM Sales_Data
ORDER BY Profit DESC LIMIT 10;
#15. Find the best-performing Sales Representative based on total Sales_Amount. 
select Sales_Rep,SUM(Sales_Amount) AS Total_Sales_Amount from sales_data Group by Sales_Rep Order by Total_Sales_Amount Desc Limit 1;
#16. Find the region with the highest total profit. 
select Region,SUM((Unit_Price-Unit_Cost)*Quantity_Sold) AS Total_Profit from sales_data Group by Region Order by Total_Profit Desc Limit 1;
#17. Get the top 5 products (Product_ID) with the highest total sales amount. 
select Product_ID As Product,MAX(Sales_Amount) As Highest_Total_Sales from sales_data Group by Product order by Highest_Total_Sales Desc Limit 5;
#18. Find the average discount offered per Product_Category. 
select product_Category,AVG(Discount) from sales_data Group by Product_category;
#19. Identify which Sales_Channel (Online vs Retail) generates more revenue. 
select Sales_Channel,SUM(Sales_Amount) AS Total_Revenue from sales_data Group by Sales_Channel Order By Total_Revenue;
#20. For each Sales_Rep, calculate their average Sales_Amount per transaction. 
select Sales_Rep,AVG(Sales_Amount) As Average_Sales_Amount from sales_data Group by Sales_Rep;
# 21. Rank Sales Representatives by total revenue using a window function.
# (Hint: RANK() OVER (ORDER BY SUM(Sales_Amount) DESC))
select Sales_Rep,Sum(Sales_Amount) AS Total_Revenue, Rank() OVER(ORDER BY SUM(Sales_Amount) DESC) AS Revenue_Rank from sales_data
 group by Sales_Rep Order by Revenue_Rank;
 # 22. Find the percentage contribution of each Region to total sales.
# (Hint: Use subquery or window sum for total.)
select Region,SUM(Sales_Amount) AS Total_sales ,Sum(Sales_Amount)*100/(Select Sum(Sales_Amount) from sales_data) 
As Percentage_Contribution from sales_data Group by Region Order by Percentage_Contribution Desc;
# 23. Display monthly sales trends (Month vs Total Sales).
select Month(Sale_Date) As Month_Number,MonthName(Sale_Date) AS Month_Name,SUM(Sales_Amount) As Total_Sales from sales_data 
Group by  Month(Sale_Date),MonthName(Sale_Date) order by MonthName(Sale_Date);
# 24. Identify any Region-Sales_Rep combinations where the total discount given exceeds 20% of total sales.
select Region, Sales_Rep, Sum(Discount) AS Total_Discount, Sum(Sales_Amount) AS Total_Sales, 
(SUM(Discount) / SUM(Sales_Amount)) * 100 AS Discount_Percentage  from sales_data Group by Region,Sales_Rep Having (SUM(Discount) / SUM(Sales_Amount)) * 100 >20 order by Discount_Percentage Desc;
#25. Compare the average sales amount between New and Returning customers. 
select Customer_Type,Round(AVG(Sales_Amount),2) AS Average_sales from sales_data Group by Customer_Type;

select * from sales_data;
