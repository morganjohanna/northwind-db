-- This file contains the code run to create each table in the database and connect them via foreign keys.

CREATE TABLE categories (
    categoryID INTEGER PRIMARY KEY,
    categoryName VARCHAR(20) UNIQUE NOT NULL,
    description VARCHAR(100) NOT NULL,
    picture BYTEA NOT NULL
    );

CREATE TABLE customers (
    customerID VARCHAR(5) PRIMARY KEY,
    companyName VARCHAR(100) UNIQUE NOT NULL,
    contactName VARCHAR(50) NOT NULL,
    contactTitle VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    city VARCHAR(20) NOT NULL,
    region VARCHAR(20),
    postalCode VARCHAR(20),
    country VARCHAR(20) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    fax VARCHAR(20)
    );

CREATE TABLE employees (
    employeeID INTEGER PRIMARY KEY,
    lastName VARCHAR(20) NOT NULL,
    firstName VARCHAR(20) NOT NULL,
    title VARCHAR(30) NOT NULL,
    titleOfCourtesy VARCHAR(5) NOT NULL,
    birthDate TIMESTAMP NOT NULL,
    hireDate TIMESTAMP NOT NULL,
    address VARCHAR(100) NOT NULL,
    city VARCHAR(20) NOT NULL,
    region VARCHAR(10),
    postalCode VARCHAR(10),
    country VARCHAR(10) NOT NULL,
    homePhone VARCHAR(20) NOT NULL,
    extension INTEGER NOT NULL,
    photo BYTEA NOT NULL,
    notes VARCHAR(255) NOT NULL,
    reportsTo INTEGER REFERENCES employees (employeeID),
    photoPath VARCHAR(100) NOT NULL
    );

CREATE TABLE regions (
    regionID INTEGER PRIMARY KEY,
    regionDescription VARCHAR(10) UNIQUE NOT NULL
    );

CREATE TABLE shippers (
    shipperID INTEGER PRIMARY KEY,
    companyName VARCHAR (20) NOT NULL,
    phone VARCHAR(20) NOT NULL
    );

CREATE TABLE suppliers (
    supplierID INTEGER PRIMARY KEY,
    companyName VARCHAR(50) NOT NULL,
    contactName VARCHAR(50) NOT NULL,
    contactTitle VARCHAR(50) NOT NULL,
    address VARCHAR(50) NOT NULL,
    city VARCHAR(20) NOT NULL,
    region VARCHAR(10),
    postalCode VARCHAR(10) NOT NULL,
    country VARCHAR(20) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    fax VARCHAR(20),
    homePage TEXT
    );

CREATE TABLE territories (
    territoryID INTEGER PRIMARY KEY,
    territoryDescription VARCHAR(20) NOT NULL,
    regionID INTEGER REFERENCES regions (regionID)
    );

CREATE TABLE orders (
    orderID INTEGER PRIMARY KEY,                         
    customerID VARCHAR(5) NOT NULL REFERENCES customers (customerID),
    employeeID INTEGER NOT NULL REFERENCES employees (employeeID),
    orderDate TIMESTAMP NOT NULL,
    requiredDate TIMESTAMP NOT NULL,
    shippedDate TIMESTAMP,
    shipVia INTEGER NOT NULL REFERENCES shippers (shipperID),
    freight NUMERIC NOT NULL,
    shipName VARCHAR(100) NOT NULL,
    shipAddress VARCHAR(100) NOT NULL,
    shipCity VARCHAR(20) NOT NULL,
    shipRegion VARCHAR(20),
    shipPostalCode VARCHAR(20),
    shipCountry VARCHAR(20) NOT NULL
    );

CREATE TABLE products (
    productID INTEGER PRIMARY KEY,
    productName VARCHAR(100) UNIQUE NOT NULL,
    supplierID INTEGER REFERENCES suppliers (supplierID),
    categoryID INTEGER REFERENCES categories (categoryID),
    quantityPerUnit VARCHAR(100) NOT NULL,
    unitPrice NUMERIC NOT NULL,
    unitsInStock INTEGER NOT NULL,
    unitsOnOrder INTEGER DEFAULT 0,
    reorderLevel INTEGER DEFAULT 0,
    discontinued BOOL
    );

CREATE TABLE employee_territories (
    employeeID INTEGER REFERENCES employees (employeeID),
    territoryID INTEGER REFERENCES territories (territoryID)
    );

CREATE TABLE order_details (
    orderID INTEGER NOT NULL REFERENCES orders (orderID),
    productID INTEGER REFERENCES products (productID),
    unitPrice NUMERIC NOT NULL,
    quantity NUMERIC NOT NULL,
    discount NUMERIC DEFAULT 0
    );

\copy categories FROM '/home/johanna/SPICED/nigela-network-student-code/Week5/data/categories.csv' DELIMITER ',' CSV HEADER NULL 'NULL'
\copy customers FROM '/home/johanna/SPICED/nigela-network-student-code/Week5/data/customers.csv' DELIMITER ',' CSV HEADER NULL 'NULL'
\copy employees FROM '/home/johanna/SPICED/nigela-network-student-code/Week5/data/employees.csv' DELIMITER ',' CSV HEADER NULL 'NULL'
\copy regions FROM '/home/johanna/SPICED/nigela-network-student-code/Week5/data/regions.csv' DELIMITER ',' CSV HEADER NULL 'NULL'
\copy shippers FROM '/home/johanna/SPICED/nigela-network-student-code/Week5/data/shippers.csv' DELIMITER ',' CSV HEADER NULL 'NULL'
\copy suppliers FROM '/home/johanna/SPICED/nigela-network-student-code/Week5/data/suppliers.csv' DELIMITER ',' CSV HEADER NULL 'NULL'
\copy territories FROM '/home/johanna/SPICED/nigela-network-student-code/Week5/data/territories.csv' DELIMITER ',' CSV HEADER NULL 'NULL'
\copy orders FROM '/home/johanna/SPICED/nigela-network-student-code/Week5/data/orders.csv' DELIMITER ',' CSV HEADER NULL 'NULL'
\copy products FROM '/home/johanna/SPICED/nigela-network-student-code/Week5/data/products.csv' DELIMITER ',' CSV HEADER NULL 'NULL'
\copy employee_territories FROM '/home/johanna/SPICED/nigela-network-student-code/Week5/data/employee_territories.csv' DELIMITER ',' CSV HEADER NULL 'NULL'
\copy order_details FROM '/home/johanna/SPICED/nigela-network-student-code/Week5/data/order_details.csv' DELIMITER ',' CSV HEADER NULL 'NULL'