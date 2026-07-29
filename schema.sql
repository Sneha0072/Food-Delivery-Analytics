CREATE DATABASE IF NOT EXISTS food_delivery_analytics;
USE food_delivery_analytics;
-- ==========================
-- Cities
-- ==========================
CREATE TABLE Cities (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    city_name VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL
);
-- ==========================
-- Customers
-- ==========================
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('Male','Female','Other') NOT NULL,
    age INT CHECK(age >= 18),
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    city_id INT,
    join_date DATE,
    FOREIGN KEY (city_id) REFERENCES Cities(city_id)
);

-- ==========================
-- Restaurants
-- ==========================
CREATE TABLE Restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50),
    city_id INT,
    rating DECIMAL(2,1),
    opening_year YEAR,
    FOREIGN KEY (city_id) REFERENCES Cities(city_id)
); 

-- ==========================
-- Delivery Partners
-- ==========================
CREATE TABLE Delivery_Partners (
    partner_id INT AUTO_INCREMENT PRIMARY KEY,
    partner_name VARCHAR(100) NOT NULL,
    vehicle_type ENUM('Bike','Scooter','Cycle') NOT NULL,
    experience_years INT,
    rating DECIMAL(2,1)
    );
    
    -- ==========================
-- Orders
-- ==========================
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    partner_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    delivery_time_minutes INT,
    order_status ENUM('Delivered','Cancelled','Preparing') NOT NULL,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id),
    FOREIGN KEY (partner_id) REFERENCES Delivery_Partners(partner_id)
);

-- ==========================
-- Order Items
-- ==========================
CREATE TABLE Order_Items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    food_name VARCHAR(100),
    category VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- ==========================
-- Payments
-- ==========================
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_method ENUM('UPI','Card','Cash','Wallet') NOT NULL,
    payment_status ENUM('Success','Failed') NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- ==========================
-- Reviews
-- ==========================
CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    customer_rating INT CHECK(customer_rating BETWEEN 1 AND 5),
    feedback VARCHAR(255),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

USE food_delivery_analytics;
SHOW TABLES;
SELECT COUNT(*) AS Total_Cities
FROM cities;

SELECT COUNT(*) AS Total_Customers
FROM customers;

SELECT COUNT(*) AS Total_delivery_partners
FROM delivery_partners;
SELECT COUNT(*) AS Total_Orders
FROM orders;

SELECT COUNT(*) AS Total_Orders_items
FROM order_items;

SELECT COUNT(*) AS Total_Payments
FROM payments;

SELECT COUNT(*) AS Total_Reviews
FROM reviews;

SELECT *
FROM customers
WHERE city_id IS NULL;

SELECT *
FROM restaurants
WHERE city_id IS NULL;

SELECT *
FROM orders
WHERE customer_id NOT IN
(
SELECT customer_id
FROM customers
);

SELECT *
FROM orders
WHERE restaurant_id NOT IN
(
SELECT restaurant_id
FROM restaurants
);

-- query one 
SELECT
ROUND(SUM(total_amount),2) AS Total_Revenue
FROM orders;

-- query 2
SELECT COUNT(*) AS Total_Orders
FROM orders;

-- Average Order Value
SELECT
ROUND(AVG(total_amount),2) AS Average_Order_Value
FROM orders;

-- Highest Order
SELECT
MAX(total_amount) AS Highest_Order
FROM orders;

-- Lowest Order
SELECT
MIN(total_amount) AS Lowest_Order
FROM orders;

SELECT COUNT(*) FROM orders;

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE reviews;
TRUNCATE TABLE payments;
TRUNCATE TABLE order_items;
TRUNCATE TABLE orders;

SET FOREIGN_KEY_CHECKS = 1;

SELECT COUNT(*) FROM orders;


SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE payments;
TRUNCATE TABLE order_items;
TRUNCATE TABLE orders;
SET FOREIGN_KEY_CHECKS = 1;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM payments;
SELECT COUNT(*) FROM reviews;
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE reviews;
SET FOREIGN_KEY_CHECKS = 1;
SELECT COUNT(*) FROM reviews;

SELECT COUNT(*) AS Orders FROM orders;
SELECT COUNT(*) AS Order_Items FROM order_items;
SELECT COUNT(*) AS Payments FROM payments;
SELECT COUNT(*) AS Reviews FROM reviews;