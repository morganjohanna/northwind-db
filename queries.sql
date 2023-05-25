-- This file contains some of the queries run to explore the dataset after the database and individual tables were created.

-- Get the names and the quantities in stock for each product.
SELECT productname, unitsinstock FROM products
    WHERE unitsinstock >0;

-- Get a list of current products (Product ID and name).
SELECT productID, productName FROM products
    WHERE discontinued = false;

-- Get a list of the most and least expensive products (name and unit price).
SELECT productName, unitPrice FROM products
    WHERE unitPrice = (SELECT MIN (unitPrice) FROM products)
        OR unitPrice = (SELECT MAX (unitPrice) FROM products);

-- Get products that cost less than $20.
SELECT productName FROM products
    WHERE unitPrice < 20;

-- Get products that cost between $15 and $25.
SELECT productName FROM products
    WHERE unitPrice < 25 AND unitPrice > 15;

-- Get products above average price.
SELECT productName FROM products
    WHERE unitPrice > (SELECT AVG (unitPrice) FROM products)

-- Find the ten most expensive products.
SELECT productName FROM products
    ORDER BY unitPrice DESC LIMIT 10;

-- Get a list of discontinued products (Product ID and name).
SELECT productID, productName FROM products
    WHERE discontinued = false;

-- Count current and discontinued products.
SELECT discontinued, COUNT (productName) FROM products
    GROUP BY discontinued;

-- Find products with less units in stock than the quantity on order.
SELECT productName FROM products
    WHERE unitsinstock < reorderlevel;

SELECT productName FROM products
    WHERE unitsinstock + unitsonorder < reorderlevel;

-- Find the customer who had the highest order amount INTERPRETED AS highest number of orders
SELECT customers.companyname, COUNT(orders.orderid) AS numberOfOrders FROM customers
    INNER JOIN orders on customers.customerid = orders.customerid
    GROUP BY customers.companyname ORDER BY 2 DESC LIMIT 1;

-- Get orders for a given employee and the according customer
SELECT employees.firstname, employees.lastname, customers.companyname, orders.orderid FROM orders
    JOIN employees ON orders.employeeid = employees.employeeid
    JOIN customers ON orders.customerid = customers.customerid
    GROUP BY employees.lastname, employees.firstname, customers.companyname, orders.orderid
    ORDER BY employees.lastname;

-- Find the hiring age of each employee
SELECT lastname, firstname, (EXTRACT ('Year' FROM hiredate) - EXTRACT('Year' FROM birthdate)) AS ageHired FROM employees;

-- Create views and/or named queries for some of these queries EXAMPLE
CREATE VIEW toReorder AS
    SELECT productName FROM products
    WHERE unitsinstock + unitsonorder < reorderlevel;