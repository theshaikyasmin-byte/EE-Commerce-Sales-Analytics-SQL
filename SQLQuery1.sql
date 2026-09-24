IF DB_ID('ECommerceAnalytics') IS
NULL
BEGIN
 CREATE DATABASE
 ECommerceAnalytics;
 END
 GO
USE ECommerceAnalytics;
GO
USE ECommerceAnalytics;
GO

IF OBJECT_ID('dbo.Customers', 'U') IS NULL
BEGIN
    CREATE TABLE Customers
    (
        CustomerID INT PRIMARY KEY,
        CustomerName VARCHAR(100),
        Email VARCHAR(100),
        City VARCHAR(50),
        State VARCHAR(50),
        SignupDate DATE
    );
END
GO
USE ECommerceAnalytics;
GO

INSERT INTO Customers
    (CustomerID, CustomerName, Email, City, State, SignupDate)
SELECT *
FROM
(
    VALUES
    (1, 'Rahul Sharma', 'rahul@gmail.com', 'Hyderabad', 'Telangana', '2025-01-10'),
    (2, 'Priya Reddy', 'priya@gmail.com', 'Vijayawada', 'Andhra Pradesh', '2025-01-15'),
    (3, 'Arjun Kumar', 'arjun@gmail.com', 'Bengaluru', 'Karnataka', '2025-02-05'),
    (4, 'Sneha Patel', 'sneha@gmail.com', 'Mumbai', 'Maharashtra', '2025-02-12'),
    (5, 'Vikram Singh', 'vikram@gmail.com', 'Delhi', 'Delhi', '2025-03-01'),
    (6, 'Ananya Rao', 'ananya@gmail.com', 'Chennai', 'Tamil Nadu', '2025-03-18'),
    (7, 'Kiran Das', 'kiran@gmail.com', 'Kolkata', 'West Bengal', '2025-04-02'),
    (8, 'Meera Nair', 'meera@gmail.com', 'Kochi', 'Kerala', '2025-04-20'),
    (9, 'Aisha Khan', 'aisha@gmail.com', 'Hyderabad', 'Telangana', '2025-05-08'),
    (10, 'Rohan Mehta', 'rohan@gmail.com', 'Pune', 'Maharashtra', '2025-05-25')
) AS NewCustomers(CustomerID, CustomerName, Email, City, State, SignupDate)
WHERE NOT EXISTS
(
    SELECT 1
    FROM Customers C
    WHERE C.CustomerID = NewCustomers.CustomerID
);
GO
SELECT *
FROM Customers
ORDER BY CustomerID;
SELECT COUNT(*) AS TotalCustomers
FROM Customers;
SELECT *
FROM Customers
WHERE City = 'Hyderabad';
SELECT *
FROM Customers
WHERE State = 'Telangana';
SELECT CustomerName, City
FROM Customers;
SELECT *
FROM Customers
ORDER BY SignupDate;
SELECT *
FROM Customers
ORDER BY SignupDate DESC;
SELECT *
FROM Customers
WHERE SignupDate > '2025-03-01';
SELECT State, COUNT(*) AS CustomerCount
FROM Customers
GROUP BY State
ORDER BY CustomerCount DESC;
SELECT City, COUNT(*) AS CustomerCount
FROM Customers
GROUP BY City
ORDER BY CustomerCount DESC;
SELECT MIN(SignupDate) AS FirstSignupDate
FROM Customers;
SELECT MAX(SignupDate) AS LatestSignupDate
FROM Customers;
SELECT *
FROM Customers
WHERE CustomerName LIKE 'A%';
SELECT
    CustomerID,
    CustomerName,
    City,
    ROW_NUMBER() OVER (ORDER BY SignupDate) AS RowNumber
FROM Customers;
SELECT
    CustomerID,
    CustomerName,
    SignupDate,
    RANK() OVER (ORDER BY SignupDate) AS CustomerRank
FROM Customers;
SELECT
    CustomerID,
    CustomerName,
    SignupDate,
    DENSE_RANK() OVER (ORDER BY SignupDate) AS CustomerDenseRank
FROM Customers;
SELECT
    CustomerID,
    CustomerName,
    State,
    ROW_NUMBER() OVER (
        PARTITION BY State
        ORDER BY SignupDate
    ) AS CustomerNumber
FROM Customers;
SELECT SUM(CustomerID) AS TotalCustomerID
FROM Customers;
SELECT AVG(CustomerID) AS AverageCustomerID
FROM Customers;
SELECT
    CustomerID,
    CustomerName,
    SignupDate,
    LAG(SignupDate) OVER (ORDER BY SignupDate) AS PreviousSignupDate,
    LEAD(SignupDate) OVER (ORDER BY SignupDate) AS NextSignupDate
FROM Customers;
CREATE TABLE Orders
(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    OrderStatus VARCHAR(20),
    TotalAmount DECIMAL(10,2),

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);
GO
USE ECommerceAnalytics;
GO
SELECT *
FROM Orders
ORDER BY OrderID;
SELECT
    Customers.CustomerID,
    Customers.CustomerName,
    Orders.OrderID,
    Orders.OrderDate,
    Orders.OrderStatus,
    Orders.TotalAmount
FROM Customers
INNER JOIN Orders
    ON Customers.CustomerID = Orders.CustomerID;
    SELECT
    C.CustomerName,
    O.OrderID,
    O.TotalAmount
FROM Customers C
LEFT JOIN Orders O
    ON C.CustomerID = O.CustomerID;
    SELECT
    C.CustomerName,
    O.OrderID,
    O.OrderDate,
    O.TotalAmount
FROM Customers C
RIGHT JOIN Orders O
    ON C.CustomerID = O.CustomerID;