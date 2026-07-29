USE food_delivery_analytics;
USE food_delivery_analytics;

-- ============================================
-- BUSINESS KPI ANALYSIS
-- ============================================

-- Total Revenue
SELECT
ROUND(SUM(total_amount),2) AS Total_Revenue
FROM Orders;

-- Total Orders
SELECT
COUNT(*) AS Total_Orders
FROM Orders;

-- Average Order Value
SELECT
ROUND(AVG(total_amount),2) AS Average_Order_Value
FROM Orders;

-- Highest Order
SELECT
MAX(total_amount) AS Highest_Order
FROM Orders;

-- Lowest Order
SELECT
MIN(total_amount) AS Lowest_Order
FROM Orders;
-- Section 1: Business KPIs
-- Query 1 — Total Revenue
SELECT
ROUND(SUM(total_amount),2) AS Total_Revenue
FROM Orders;

-- Query 2 — Total Orders
SELECT
COUNT(*) AS Total_Orders
FROM Orders;

-- Query 3 — Average Order Value
SELECT
ROUND(AVG(total_amount),2) AS Average_Order_Value
FROM Orders;

-- Query 4 — Highest Order Amount
SELECT
MAX(total_amount) AS Highest_Order
FROM Orders;

-- Query 5 — Lowest Order Amount
SELECT
MIN(total_amount) AS Lowest_Order
FROM Orders; 

-- Query 6 — Total Customers
SELECT
COUNT(*) AS Total_Customers
FROM Customers;

-- Query 7 — Total Restaurants
SELECT
COUNT(*) AS Total_Restaurants
FROM Restaurants;

-- Query 9 — Total Payments
SELECT
COUNT(*) AS Total_Payments
FROM Payments;

-- Query 10 — Average Delivery Time
SELECT
ROUND(AVG(delivery_time_minutes),2) AS Average_Delivery_Time
FROM Orders;

-- Section 2: Order Analysis
-- Query 11 — Orders by Status
SELECT
order_status,
COUNT(*) AS Total_Orders
FROM Orders
GROUP BY order_status
ORDER BY Total_Orders DESC;

-- Query 12 — Revenue by Order Status
SELECT
order_status,
ROUND(SUM(total_amount),2) AS Revenue
FROM Orders
GROUP BY order_status;

-- Query 13 — Top 10 Highest Orders
SELECT
order_id,
total_amount
FROM Orders
ORDER BY total_amount DESC
LIMIT 10;

-- Query 14 — Orders Above ₹1000
SELECT *
FROM Orders
WHERE total_amount >1000;

-- Query 15 — Orders Between ₹500 and ₹1000
SELECT *
FROM Orders
WHERE total_amount
BETWEEN 500 AND 1000;

 -- Section 3: Customer Analytics
-- Query 16 — Top 10 Customers by Spending
SELECT
c.customer_id,
CONCAT(c.first_name,' ',c.last_name) AS Customer,
ROUND(SUM(o.total_amount),2) AS Total_Spent
FROM Customers c
JOIN Orders o
ON c.customer_id=o.customer_id
GROUP BY
c.customer_id,
Customer
ORDER BY Total_Spent DESC
LIMIT 10;

-- Query 17 — Top 10 Customers by Orders
SELECT
c.customer_id,
CONCAT(c.first_name,' ',c.last_name) AS Customer,
COUNT(*) AS Orders_Placed
FROM Customers c
JOIN Orders o
ON c.customer_id=o.customer_id
GROUP BY
c.customer_id,
Customer
ORDER BY Orders_Placed DESC
LIMIT 10;

-- Query 18 — Customer Distribution by Gender
SELECT
gender,
COUNT(*) AS Total_Customers
FROM Customers
GROUP BY gender;

-- Query 19 — Average Customer Age
SELECT
ROUND(AVG(age),2) AS Average_Age
FROM Customers;

-- Query 20 — Customers by City
SELECT
ci.city_name,
COUNT(*) AS Customers
FROM Customers c
JOIN Cities ci
ON c.city_id=ci.city_id
GROUP BY ci.city_name
ORDER BY Customers DESC;

-- MODULE 2 – Restaurant Analytics
-- Query 21 – Top 10 Restaurants by Revenue
SELECT
    r.restaurant_id,
    r.restaurant_name,
    ROUND(SUM(o.total_amount),2) AS Total_Revenue
FROM Restaurants r
JOIN Orders o
ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY Total_Revenue DESC
LIMIT 10;

-- Query 22 – Top 10 Restaurants by Orders
SELECT
    r.restaurant_name,
    COUNT(o.order_id) AS Total_Orders
FROM Restaurants r
JOIN Orders o
ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_name
ORDER BY Total_Orders DESC
LIMIT 10;

-- Query 23 – Average Order Value by Restaurant
SELECT
    r.restaurant_name,
    ROUND(AVG(o.total_amount),2) AS Average_Order_Value
FROM Restaurants r
JOIN Orders o
ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_name
ORDER BY Average_Order_Value DESC;

-- Query 24 – Restaurant Ratings
SELECT
    restaurant_name,
    rating
FROM Restaurants
ORDER BY rating DESC;

-- Query 25 – Restaurants by Cuisine
SELECT
    cuisine,
    COUNT(*) AS Total_Restaurants
FROM Restaurants
GROUP BY cuisine
ORDER BY Total_Restaurants DESC;

-- MODULE 2 – Cuisine Analytics
-- Query 26 – Revenue by Cuisine
SELECT
    r.cuisine,
    ROUND(SUM(o.total_amount),2) AS Revenue
FROM Restaurants r
JOIN Orders o
ON r.restaurant_id = o.restaurant_id
GROUP BY r.cuisine
ORDER BY Revenue DESC;

-- Query 27 – Orders by Cuisine
SELECT
    r.cuisine,
    COUNT(*) AS Total_Orders
FROM Restaurants r
JOIN Orders o
ON r.restaurant_id = o.restaurant_id
GROUP BY r.cuisine
ORDER BY Total_Orders DESC;

-- Query 28 – Average Restaurant Rating by Cuisine
SELECT
    cuisine,
    ROUND(AVG(rating),2) AS Average_Rating
FROM Restaurants
GROUP BY cuisine
ORDER BY Average_Rating DESC;

-- MODULE 2 – Delivery Partner Analytics
-- Query 29 – Top 10 Delivery Partners by Orders
SELECT
    d.partner_name,
    COUNT(o.order_id) AS Total_Deliveries
FROM Delivery_Partners d
JOIN Orders o
ON d.partner_id = o.partner_id
GROUP BY d.partner_name
ORDER BY Total_Deliveries DESC
LIMIT 10;

-- Query 30 – Average Delivery Time by Partner
SELECT
    d.partner_name,
    ROUND(AVG(o.delivery_time_minutes),2) AS Average_Delivery_Time
FROM Delivery_Partners d
JOIN Orders o
ON d.partner_id = o.partner_id
GROUP BY d.partner_name
ORDER BY Average_Delivery_Time;

-- Query 31 – Delivery Partners by Vehicle Type
SELECT
    vehicle_type,
    COUNT(*) AS Total_Partners
FROM Delivery_Partners
GROUP BY vehicle_type;

-- Query 32 – Average Partner Rating
SELECT
    ROUND(AVG(rating),2) AS Average_Rating
FROM Delivery_Partners;

-- Query 33 – Highest Rated Delivery Partners
SELECT
    partner_name,
    rating
FROM Delivery_Partners
ORDER BY rating DESC
LIMIT 10;

-- MODULE 2 – Payment Analytics
-- Query 34 – Payment Method Usage
SELECT
    payment_method,
    COUNT(*) AS Total_Transactions
FROM Payments
GROUP BY payment_method
ORDER BY Total_Transactions DESC;

-- Query 35 – Payment Status
SELECT
    payment_status,
    COUNT(*) AS Total
FROM Payments
GROUP BY payment_status;

-- Query 36 – Successful Payments
SELECT
    COUNT(*) AS Successful_Payments
FROM Payments
WHERE payment_status = 'Success';

-- Query 37 – Failed Payments
SELECT
    COUNT(*) AS Failed_Payments
FROM Payments
WHERE payment_status = 'Failed';

-- MODULE 2 – Reviews Analytics
-- Query 38 – Average Customer Rating
SELECT
    ROUND(AVG(customer_rating),2) AS Average_Customer_Rating
FROM Reviews;

-- Query 39 – Rating Distribution
SELECT
    customer_rating,
    COUNT(*) AS Total_Reviews
FROM Reviews
GROUP BY customer_rating
ORDER BY customer_rating;

-- Query 40 – Top Feedback Comments
SELECT
    feedback,
    COUNT(*) AS Frequency
FROM Reviews
GROUP BY feedback
ORDER BY Frequency DESC;

-- MODULE 2 – City Analytics
-- Query 41 – Customers by City
SELECT
    c.city_name,
    COUNT(cu.customer_id) AS Total_Customers
FROM Cities c
JOIN Customers cu
ON c.city_id = cu.city_id
GROUP BY c.city_name
ORDER BY Total_Customers DESC;

-- Query 42 – Restaurants by City
SELECT
    c.city_name,
    COUNT(r.restaurant_id) AS Total_Restaurants
FROM Cities c
JOIN Restaurants r
ON c.city_id = r.city_id
GROUP BY c.city_name
ORDER BY Total_Restaurants DESC;

-- Query 43 – Revenue by City
SELECT
    c.city_name,
    ROUND(SUM(o.total_amount),2) AS Revenue
FROM Cities c
JOIN Customers cu
ON c.city_id = cu.city_id
JOIN Orders o
ON cu.customer_id = o.customer_id
GROUP BY c.city_name
ORDER BY Revenue DESC;

-- MODULE 2 – Date Analytics
-- Query 44 – Monthly Revenue
SELECT
    MONTHNAME(order_date) AS Month,
    ROUND(SUM(total_amount),2) AS Revenue
FROM Orders
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY MONTH(order_date);

-- Query 45 – Monthly Orders
SELECT
    MONTHNAME(order_date) AS Month,
    COUNT(*) AS Orders
FROM Orders
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY MONTH(order_date);

-- Query 46 – Yearly Revenue
SELECT
    YEAR(order_date) AS Year,
    ROUND(SUM(total_amount),2) AS Revenue
FROM Orders
GROUP BY YEAR(order_date)
ORDER BY Year;

-- Query 47 – Orders by Day of Week
SELECT
    DAYNAME(order_date) AS Day,
    COUNT(*) AS Total_Orders
FROM Orders
GROUP BY DAYNAME(order_date)
ORDER BY Total_Orders DESC;

-- Query 48 – Peak Ordering Hour
SELECT
    HOUR(order_date) AS Hour,
    COUNT(*) AS Total_Orders
FROM Orders
GROUP BY HOUR(order_date)
ORDER BY Total_Orders DESC;

-- MODULE 3 - Advanced SQL
-- Section 1 - HAVING Clause
-- Query 49 - Customers Who Placed More Than 20 Orders
SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS Customer_Name,
    COUNT(o.order_id) AS Total_Orders
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, Customer_Name
HAVING COUNT(o.order_id) > 20
ORDER BY Total_Orders DESC;

-- Query 50 - Restaurants With Revenue Greater Than ₹50,000
SELECT
    r.restaurant_name,
    ROUND(SUM(o.total_amount),2) AS Revenue
FROM Restaurants r
JOIN Orders o
ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_name
HAVING Revenue > 50000
ORDER BY Revenue DESC;

-- Query 51 - Cities Having More Than 50 Customers
SELECT
    ci.city_name,
    COUNT(c.customer_id) AS Customers
FROM Cities ci
JOIN Customers c
ON ci.city_id = c.city_id
GROUP BY ci.city_name
HAVING Customers > 50;

-- Section 2 - CASE Statement
-- Query 52 - Order Category
SELECT
    order_id,
    total_amount,
    CASE
        WHEN total_amount < 300 THEN 'Low Value'
        WHEN total_amount BETWEEN 300 AND 800 THEN 'Medium Value'
        ELSE 'High Value'
    END AS Order_Category
FROM Orders;

-- Query 53 - Delivery Speed
SELECT
order_id,
delivery_time_minutes,
CASE
WHEN delivery_time_minutes <=30 THEN 'Fast'
WHEN delivery_time_minutes <=45 THEN 'Average'
ELSE 'Slow'
END AS Delivery_Type
FROM Orders;

-- Section 3 - Subqueries
-- Query 54 - Customers Spending Above Average
SELECT
customer_id,
first_name,
last_name
FROM Customers
WHERE customer_id IN (
SELECT customer_id
FROM Orders
GROUP BY customer_id
HAVING AVG(total_amount) >
(
SELECT AVG(total_amount)
FROM Orders
)
);

-- Query 55 - Orders Greater Than Overall Average
SELECT *
FROM Orders
WHERE total_amount >
(
SELECT AVG(total_amount)
FROM Orders
);

-- Query 56 - Highest Revenue Restaurant
SELECT
restaurant_name
FROM Restaurants
WHERE restaurant_id=
(
SELECT restaurant_id
FROM Orders
GROUP BY restaurant_id
ORDER BY SUM(total_amount) DESC
LIMIT 1
);

-- Section 4 - Common Table Expressions (CTE)
-- Query 57 - Top Customers
WITH CustomerRevenue AS
(
SELECT
customer_id,
ROUND(SUM(total_amount),2) AS Revenue
FROM Orders
GROUP BY customer_id
)
SELECT *
FROM CustomerRevenue
ORDER BY Revenue DESC
LIMIT 10;

-- Query 58 - Monthly Revenue
WITH MonthlyRevenue AS
(
SELECT
MONTH(order_date) MonthNo,
MONTHNAME(order_date) Month,
SUM(total_amount) Revenue
FROM Orders
GROUP BY MonthNo,Month
)
SELECT *
FROM MonthlyRevenue
ORDER BY MonthNo;

-- Section 5 - Window Functions
-- Query 59 - Rank Customers by Spending
WITH CustomerRevenue AS
(
    SELECT
        customer_id,
        SUM(total_amount) AS Revenue
    FROM Orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    Revenue,
    RANK() OVER (ORDER BY Revenue DESC) AS Customer_Rank
FROM CustomerRevenue;

-- Query 60 – Customer Dense Rank
WITH CustomerRevenue AS
(
    SELECT
        customer_id,
        SUM(total_amount) AS Revenue
    FROM Orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    Revenue,
    DENSE_RANK() OVER (ORDER BY Revenue DESC) AS Customer_Dense_Rank
FROM CustomerRevenue;

-- Query 61 – Customer Row Number
WITH CustomerRevenue AS
(
    SELECT
        customer_id,
        SUM(total_amount) AS Revenue
    FROM Orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    Revenue,
    ROW_NUMBER() OVER (ORDER BY Revenue DESC) AS Row_No
FROM CustomerRevenue;

-- Query 62 – Previous Order Amount (LAG)
SELECT
    order_id,
    customer_id,
    total_amount,
    LAG(total_amount)
        OVER(
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS Previous_Order
FROM Orders;

-- Query 63 – Next Order Amount (LEAD)
SELECT
    order_id,
    customer_id,
    total_amount,
    LEAD(total_amount)
        OVER(
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS Next_Order
FROM Orders;

-- Query 64 – Running Revenue
SELECT
    order_date,
    total_amount,

    SUM(total_amount)
    OVER(
        ORDER BY order_date
    ) AS Running_Revenue

FROM Orders;

-- Query 65 – Moving Average (5 Orders)
SELECT
order_id,
order_date,
total_amount,
AVG(total_amount)
OVER(
ORDER BY order_date
ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
) AS Moving_Average
FROM Orders;

-- 	Query 66 – First Order Amount
SELECT
customer_id,
order_date,
total_amount,
FIRST_VALUE(total_amount)
OVER(
PARTITION BY customer_id
ORDER BY order_date
) AS First_Order
FROM Orders;

-- Query 67 – Last Order Amount
SELECT
customer_id,
order_date,
total_amount,
LAST_VALUE(total_amount)
OVER(
PARTITION BY customer_id
ORDER BY order_date
ROWS BETWEEN UNBOUNDED PRECEDING
AND UNBOUNDED FOLLOWING
) AS Last_Order
FROM Orders;

-- Query 68 – Revenue Quartile
WITH CustomerRevenue AS
(
SELECT
customer_id,
SUM(total_amount) Revenue
FROM Orders
GROUP BY customer_id
)
SELECT
customer_id,
Revenue,
NTILE(4)
OVER(
ORDER BY Revenue DESC
) Revenue_Quartile
FROM CustomerRevenue;

-- Query 69 – Restaurant Revenue Rank
WITH RestaurantRevenue AS
(
SELECT
restaurant_id,
SUM(total_amount) Revenue
FROM Orders
GROUP BY restaurant_id
)
SELECT
restaurant_id,
Revenue,
RANK()
OVER(
ORDER BY Revenue DESC
) Restaurant_Rank
FROM RestaurantRevenue;

-- Query 70 – Running Orders per Customer
SELECT
customer_id,
order_date,
order_id,
COUNT(*)
OVER(
PARTITION BY customer_id
ORDER BY order_date
) Running_Orders
FROM Orders;

