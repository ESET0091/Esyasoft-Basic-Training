create database AssignmentDB;
use AssignmentDB;
-- Create Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50),
    Salary DECIMAL(10,2),
    ManagerID INT,
    HireDate DATE
);

-- Create Sales table
CREATE TABLE Sales (
    SaleID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    ProductCategory NVARCHAR(50),
    SaleAmount DECIMAL(10,2),
    SaleDate DATE,
    Region NVARCHAR(50)
);

-- Insert sample data into Employees
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, ManagerID, HireDate) VALUES
(1, 'John', 'Smith', 'IT', 75000, NULL, '2020-01-15'),
(2, 'Sarah', 'Johnson', 'IT', 65000, 1, '2021-03-20'),
(3, 'Mike', 'Brown', 'HR', 60000, NULL, '2019-06-10'),
(4, 'Emily', 'Davis', 'HR', 55000, 3, '2022-01-30'),
(5, 'David', 'Wilson', 'Sales', 70000, NULL, '2018-11-05'),
(6, 'Lisa', 'Miller', 'Sales', 62000, 5, '2021-07-15'),
(7, 'Tom', 'Anderson', 'IT', 68000, 1, '2020-09-12'),
(8, 'Jennifer', 'Lee', 'Sales', 58000, 5, '2023-02-28');

-- Insert sample data into Sales
INSERT INTO Sales (EmployeeID, ProductCategory, SaleAmount, SaleDate, Region) VALUES
(5, 'Electronics', 1500.00, '2024-01-15', 'North'),
(6, 'Electronics', 800.00, '2024-01-16', 'South'),
(5, 'Furniture', 2200.00, '2024-01-17', 'North'),
(8, 'Electronics', 950.00, '2024-01-18', 'East'),
(6, 'Furniture', 1800.00, '2024-02-01', 'South'),
(5, 'Electronics', 1200.00, '2024-02-02', 'North'),
(8, 'Furniture', 2500.00, '2024-02-03', 'East'),
(6, 'Electronics', 700.00, '2024-02-04', 'South'),
(5, 'Furniture', 1900.00, '2024-03-10', 'North'),
(8, 'Electronics', 1100.00, '2024-03-11', 'East'),
(6, 'Furniture', 2100.00, '2024-03-12', 'South');

-- View the tables
SELECT * FROM Employees;
SELECT * FROM Sales;

-- CTE for employee hierarchy
WITH EmployeeHierarchy AS (
    -- Anchor: Employees with no manager (top level)
    SELECT 
        EmployeeID,
        FirstName,
        LastName,
        Department,
        ManagerID,
        0 AS HierarchyLevel,
        CAST(FirstName + ' ' + LastName AS NVARCHAR(255)) AS HierarchyPath
    FROM Employees
    WHERE ManagerID IS NULL
    
    UNION ALL
    
    -- Recursive: Employees with managers
    SELECT 
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        e.Department,
        e.ManagerID,
        eh.HierarchyLevel + 1,
        CAST(eh.HierarchyPath + ' -> ' + e.FirstName + ' ' + e.LastName AS NVARCHAR(255))
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT 
    EmployeeID,
    FirstName + ' ' + LastName AS EmployeeName,
    Department,
    HierarchyLevel,
    HierarchyPath
FROM EmployeeHierarchy
ORDER BY HierarchyLevel, EmployeeName;

-- CTE for sales analysis
WITH SalesSummary AS (
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS EmployeeName,
        e.Department,
        s.ProductCategory,
        YEAR(s.SaleDate) AS SaleYear,
        MONTH(s.SaleDate) AS SaleMonth,
        SUM(s.SaleAmount) AS TotalSales,
        COUNT(*) AS SaleCount
    FROM Employees e
    INNER JOIN Sales s ON e.EmployeeID = s.EmployeeID
    GROUP BY e.EmployeeID, e.FirstName, e.LastName, e.Department, s.ProductCategory, 
             YEAR(s.SaleDate), MONTH(s.SaleDate)
),
RankedSales AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY SaleYear, SaleMonth ORDER BY TotalSales DESC) AS SalesRank
    FROM SalesSummary
)
SELECT 
    EmployeeName,
    Department,
    ProductCategory,
    SaleYear,
    SaleMonth,
    TotalSales,
    SaleCount,
    SalesRank
FROM RankedSales
WHERE SalesRank <= 3
ORDER BY SaleYear DESC, SaleMonth DESC, SalesRank;



-- Static PIVOT: Sales by product category per month
SELECT 
    EmployeeName,
    [Electronics],
    [Furniture]
FROM (
    SELECT 
        e.FirstName + ' ' + e.LastName AS EmployeeName,
        s.ProductCategory,
        SUM(s.SaleAmount) AS TotalSales
    FROM Employees e
    INNER JOIN Sales s ON e.EmployeeID = s.EmployeeID
    WHERE YEAR(s.SaleDate) = 2024
    GROUP BY e.FirstName, e.LastName, s.ProductCategory
) AS SourceTable
PIVOT (
    SUM(TotalSales)
    FOR ProductCategory IN ([Electronics], [Furniture])
) AS PivotTable
ORDER BY EmployeeName;

-- Dynamic PIVOT: Sales by region (dynamic columns)
DECLARE @RegionColumns NVARCHAR(MAX), @DynamicPivotSQL NVARCHAR(MAX);

-- Get distinct regions for columns
SELECT @RegionColumns = COALESCE(@RegionColumns + ',', '') + QUOTENAME(Region)
FROM (
    SELECT DISTINCT Region
    FROM Sales
    WHERE Region IS NOT NULL
) AS Regions;

-- Build dynamic SQL
SET @DynamicPivotSQL = '
SELECT 
    ProductCategory,
    ' + @RegionColumns + '
FROM (
    SELECT 
        ProductCategory,
        Region,
        SUM(SaleAmount) AS TotalSales
    FROM Sales
    WHERE YEAR(SaleDate) = 2024
    GROUP BY ProductCategory, Region
) AS SourceTable
PIVOT (
    SUM(TotalSales)
    FOR Region IN (' + @RegionColumns + ')
) AS PivotTable
ORDER BY ProductCategory';

-- Execute dynamic PIVOT
EXEC sp_executesql @DynamicPivotSQL;


-- Employee classification with CASE
SELECT 
    EmployeeID,
    FirstName + ' ' + LastName AS EmployeeName,
    Department,
    Salary,
    CASE 
        WHEN Salary >= 70000 THEN 'High'
        WHEN Salary >= 60000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryGrade,
    CASE Department
        WHEN 'IT' THEN 'Technology'
        WHEN 'HR' THEN 'Human Resources'
        WHEN 'Sales' THEN 'Sales & Marketing'
        ELSE 'Other'
    END AS DepartmentGroup,
    DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsWithCompany,
    CASE 
        WHEN DATEDIFF(YEAR, HireDate, GETDATE()) >= 5 THEN 'Veteran'
        WHEN DATEDIFF(YEAR, HireDate, GETDATE()) >= 2 THEN 'Experienced'
        ELSE 'New'
    END AS ExperienceLevel
FROM Employees
ORDER BY Salary DESC;

-- Sales performance analysis with conditional aggregation
SELECT 
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    e.Department,
    COUNT(s.SaleID) AS TotalSales,
    SUM(s.SaleAmount) AS TotalRevenue,
    AVG(s.SaleAmount) AS AverageSale,
    -- Conditional counts
    SUM(CASE WHEN s.SaleAmount > 1000 THEN 1 ELSE 0 END) AS HighValueSales,
    SUM(CASE WHEN s.SaleAmount <= 1000 THEN 1 ELSE 0 END) AS StandardSales,
    -- Conditional revenue by product category
    SUM(CASE WHEN s.ProductCategory = 'Electronics' THEN s.SaleAmount ELSE 0 END) AS ElectronicsRevenue,
    SUM(CASE WHEN s.ProductCategory = 'Furniture' THEN s.SaleAmount ELSE 0 END) AS FurnitureRevenue,
    -- Performance rating
    CASE 
        WHEN AVG(s.SaleAmount) > 1500 THEN 'Excellent'
        WHEN AVG(s.SaleAmount) > 1000 THEN 'Good'
        WHEN AVG(s.SaleAmount) > 500 THEN 'Average'
        ELSE 'Needs Improvement'
    END AS PerformanceRating
FROM Employees e
LEFT JOIN Sales s ON e.EmployeeID = s.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName, e.Department
ORDER BY TotalRevenue DESC;





-- Create Customers table with JSON column
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName NVARCHAR(100),
    ContactInfo NVARCHAR(MAX), -- JSON column
    CreatedDate DATETIME2 DEFAULT GETDATE()
);

-- Create Orders table with JSON column
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    OrderData NVARCHAR(MAX), -- JSON column
    OrderDate DATE,
    Status NVARCHAR(20)
);

-- Insert sample JSON data into Customers
INSERT INTO Customers (CustomerName, ContactInfo) VALUES
('John Smith', '{
    "email": "john.smith@email.com",
    "phone": "+1-555-0101",
    "address": {
        "street": "123 Main St",
        "city": "New York",
        "state": "NY",
        "zipCode": "10001"
    },
    "preferences": {
        "newsletter": true,
        "notifications": ["email", "sms"],
        "language": "en"
    }
}'),
('Sarah Johnson', '{
    "email": "sarah.j@email.com",
    "phone": "+1-555-0102",
    "address": {
        "street": "456 Oak Ave",
        "city": "Los Angeles",
        "state": "CA",
        "zipCode": "90210"
    },
    "preferences": {
        "newsletter": false,
        "notifications": ["email"],
        "language": "en"
    }
}'),
('Mike Brown', '{
    "email": "mike.brown@email.com",
    "phone": "+1-555-0103",
    "address": {
        "street": "789 Pine Rd",
        "city": "Chicago",
        "state": "IL",
        "zipCode": "60601"
    },
    "preferences": {
        "newsletter": true,
        "notifications": ["push", "sms"],
        "language": "es"
    }
}');

-- Insert sample JSON data into Orders
INSERT INTO Orders (CustomerID, OrderData, OrderDate, Status) VALUES
(1, '{
    "orderNumber": "ORD001",
    "items": [
        {"productId": 101, "name": "Laptop", "quantity": 1, "price": 999.99, "category": "Electronics"},
        {"productId": 205, "name": "Mouse", "quantity": 2, "price": 25.50, "category": "Electronics"}
    ],
    "payment": {
        "method": "Credit Card",
        "amount": 1050.99,
        "currency": "USD"
    },
    "shipping": {
        "method": "Express",
        "address": "123 Main St, New York, NY 10001"
    }
}', '2024-01-15', 'Completed'),
(2, '{
    "orderNumber": "ORD002",
    "items": [
        {"productId": 305, "name": "Office Chair", "quantity": 1, "price": 299.99, "category": "Furniture"},
        {"productId": 410, "name": "Desk Lamp", "quantity": 1, "price": 45.99, "category": "Home"}
    ],
    "payment": {
        "method": "PayPal",
        "amount": 345.98,
        "currency": "USD"
    },
    "shipping": {
        "method": "Standard",
        "address": "456 Oak Ave, Los Angeles, CA 90210"
    }
}', '2024-01-18', 'Completed'),
(1, '{
    "orderNumber": "ORD003",
    "items": [
        {"productId": 150, "name": "Tablet", "quantity": 1, "price": 399.99, "category": "Electronics"},
        {"productId": 220, "name": "Keyboard", "quantity": 1, "price": 79.99, "category": "Electronics"},
        {"productId": 180, "name": "Monitor", "quantity": 1, "price": 249.99, "category": "Electronics"}
    ],
    "payment": {
        "method": "Credit Card",
        "amount": 729.97,
        "currency": "USD"
    },
    "shipping": {
        "method": "Express",
        "address": "123 Main St, New York, NY 10001"
    }
}', '2024-02-01', 'Processing');

-- View the tables with JSON data              
SELECT * FROM Customers;
SELECT * FROM Orders;



-- Extract scalar values from JSON using JSON_VALUE
SELECT 
    CustomerID,
    CustomerName,
    JSON_VALUE(ContactInfo, '$.email') AS Email,
    JSON_VALUE(ContactInfo, '$.phone') AS Phone,
    JSON_VALUE(ContactInfo, '$.address.city') AS City,
    JSON_VALUE(ContactInfo, '$.address.state') AS State,
    JSON_VALUE(ContactInfo, '$.preferences.newsletter') AS NewsletterSubscribed,
    JSON_VALUE(ContactInfo, '$.preferences.language') AS Language
FROM Customers;

-- Extract objects and arrays using JSON_QUERY
SELECT 
    CustomerID,
    CustomerName,
    JSON_QUERY(ContactInfo, '$.address') AS FullAddress,
    JSON_QUERY(ContactInfo, '$.preferences') AS Preferences,
    JSON_QUERY(ContactInfo, '$.preferences.notifications') AS NotificationMethods
FROM Customers;



-- Parse JSON arrays from Orders table using OPENJSON
SELECT 
    o.OrderID,
    o.OrderNumber,
    o.CustomerName,
    items.productId,
    items.name AS ProductName,
    items.quantity,
    items.price,
    items.category
FROM (
    SELECT 
        o.OrderID,
        JSON_VALUE(o.OrderData, '$.orderNumber') AS OrderNumber,
        c.CustomerName,
        JSON_QUERY(o.OrderData, '$.items') AS ItemsArray
    FROM Orders o
    INNER JOIN Customers c ON o.CustomerID = c.CustomerID
) AS o
CROSS APPLY OPENJSON(o.ItemsArray)
WITH (
    productId INT '$.productId',
    name NVARCHAR(100) '$.name',
    quantity INT '$.quantity',
    price DECIMAL(10,2) '$.price',
    category NVARCHAR(50) '$.category'
) AS items;

-- Complex JSON parsing with multiple levels
SELECT 
    o.OrderID,
    JSON_VALUE(o.OrderData, '$.orderNumber') AS OrderNumber,
    c.CustomerName,
    JSON_VALUE(c.ContactInfo, '$.email') AS CustomerEmail,
    JSON_VALUE(o.OrderData, '$.payment.method') AS PaymentMethod,
    JSON_VALUE(o.OrderData, '$.payment.amount') AS PaymentAmount,
    JSON_VALUE(o.OrderData, '$.shipping.method') AS ShippingMethod,
    o.OrderDate,
    o.Status
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID;



-- Update JSON data using JSON_MODIFY
-- Add loyalty points to customer contact info
UPDATE Customers 
SET ContactInfo = JSON_MODIFY(ContactInfo, '$.loyaltyPoints', 150)
WHERE CustomerID = 1;

-- Add new notification method to preferences
UPDATE Customers 
SET ContactInfo = JSON_MODIFY(
    ContactInfo, 
    '$.preferences.notifications', 
    JSON_QUERY('["email", "sms", "push"]')
)
WHERE CustomerID = 2;

-- Modify order status in JSON and add update timestamp
UPDATE Orders 
SET OrderData = JSON_MODIFY(
    JSON_MODIFY(OrderData, '$.status', 'Shipped'),
    '$.shipmentDate', CONVERT(VARCHAR, GETDATE(), 120)
)
WHERE OrderID = 3;

-- Verify the updates
SELECT 
    CustomerID,
    CustomerName,
    ContactInfo
FROM Customers
WHERE CustomerID IN (1, 2);

SELECT 
    OrderID,
    OrderData
FROM Orders
WHERE OrderID = 3;



-- Comprehensive JSON analysis using all techniques
WITH CustomerOrders AS (
    SELECT 
        c.CustomerID,
        c.CustomerName,
        JSON_VALUE(c.ContactInfo, '$.email') AS Email,
        JSON_VALUE(c.ContactInfo, '$.address.city') AS City,
        JSON_VALUE(c.ContactInfo, '$.preferences.newsletter') AS Newsletter,
        o.OrderID,
        JSON_VALUE(o.OrderData, '$.orderNumber') AS OrderNumber,
        CAST(JSON_VALUE(o.OrderData, '$.payment.amount') AS DECIMAL(10,2)) AS OrderAmount,
        JSON_VALUE(o.OrderData, '$.payment.method') AS PaymentMethod,
        o.OrderDate,
        o.Status
    FROM Customers c
    INNER JOIN Orders o ON c.CustomerID = o.CustomerID
),
OrderItems AS (
    SELECT 
        o.OrderID,
        items.productId,
        items.name AS ProductName,
        items.quantity,
        items.price,
        items.category
    FROM Orders o
    CROSS APPLY OPENJSON(o.OrderData, '$.items')
    WITH (
        productId INT '$.productId',
        name NVARCHAR(100) '$.name',
        quantity INT '$.quantity',
        price DECIMAL(10,2) '$.price',
        category NVARCHAR(50) '$.category'
    ) AS items
),
CustomerSummary AS (
    SELECT 
        co.CustomerID,
        co.CustomerName,
        co.City,
        co.Newsletter,
        COUNT(DISTINCT co.OrderID) AS TotalOrders,
        SUM(co.OrderAmount) AS TotalSpent,
        AVG(co.OrderAmount) AS AvgOrderValue,
        MAX(co.OrderAmount) AS MaxOrderValue
    FROM CustomerOrders co
    GROUP BY co.CustomerID, co.CustomerName, co.City, co.Newsletter
)
SELECT 
    cs.CustomerName,
    cs.City,
    cs.TotalOrders,
    cs.TotalSpent,
    cs.AvgOrderValue,
    cs.MaxOrderValue,
    cs.Newsletter,
    oi.TopProduct,
    oi.TotalProducts
FROM CustomerSummary cs
CROSS APPLY (
    SELECT 
        TOP 1 ProductName AS TopProduct,
        COUNT(*) AS TotalProducts
    FROM OrderItems oi_sub
    INNER JOIN Orders o ON oi_sub.OrderID = o.OrderID
    WHERE o.CustomerID = cs.CustomerID
    GROUP BY ProductName
    ORDER BY COUNT(*) DESC
) AS oi
ORDER BY cs.TotalSpent DESC;









-- Pivot --
SELECT 
    EmployeeName,
    [Electronics],
    [Furniture]
FROM (
    SELECT 
        e.FirstName + ' ' + e.LastName AS EmployeeName,
        s.ProductCategory,
        SUM(s.SaleAmount) AS TotalSales
    FROM Employees e
    INNER JOIN Sales s ON e.EmployeeID = s.EmployeeID
    WHERE YEAR(s.SaleDate) = 2024
    GROUP BY e.FirstName, e.LastName, s.ProductCategory
) AS SourceTable
PIVOT (
    SUM(TotalSales)
    FOR ProductCategory IN ([Electronics], [Furniture])
) AS PivotTable
ORDER BY EmployeeName;