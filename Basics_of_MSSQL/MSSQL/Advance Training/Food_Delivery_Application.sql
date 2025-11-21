create Database FomatoDB;
use FomatoDB;


-- 1. Users Table
CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL,CHECK (Email LIKE '%_@__%.__%'),
    Phone NVARCHAR(20),
    Password NVARCHAR(255) NOT NULL  
);
ALTER TABLE Users
ADD CONSTRAINT CHK_Users_Email_Format 
CHECK (Email LIKE '%_@__%.__%');

ALTER TABLE Users
ADD CONSTRAINT CHK_Users_Phone_Numeric 
CHECK (Phone NOT LIKE '%[^0-9]%');

Select * from Users;

--------------------
CREATE PROCEDURE InsertUserSimple
    @Name NVARCHAR(100),
    @Email NVARCHAR(255),
    @Phone NVARCHAR(20) = NULL,
    @Password NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO Users (Name, Email, Phone, Password)
    VALUES (@Name, @Email, @Phone, @Password);
    
    SELECT SCOPE_IDENTITY() AS UserId;
END
---------------------------

-- 2. Addresses Table
CREATE TABLE Addresses (
    AddressId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    Street NVARCHAR(255) NOT NULL,
    City NVARCHAR(100) NOT NULL,
    State NVARCHAR(100) NOT NULL,
    ZipCode NVARCHAR(20) NOT NULL,
    Country NVARCHAR(100) DEFAULT 'India',
    AddressType NVARCHAR(50) NOT NULL, -- Home, Work, Other
    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);


-- 3. Restaurants Table
CREATE TABLE Restaurants (
    RestaurantId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    CuisineType NVARCHAR(100),
    Phone NVARCHAR(20),
    Email NVARCHAR(255),
    Street NVARCHAR(255),
    City NVARCHAR(100),
    State NVARCHAR(100),
    ZipCode NVARCHAR(20),
    Rating DECIMAL(3,2) DEFAULT 0.0
);


-- 4. FoodItems Table
CREATE TABLE FoodItems (
    ItemId INT PRIMARY KEY IDENTITY(1,1),
    RestaurantId INT NOT NULL,
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(500),
    Price DECIMAL(10,2) NOT NULL,
    Category NVARCHAR(100),
    IsAvailable BIT DEFAULT 1,
    PreparationTime INT DEFAULT 20, -- in minutes
    FOREIGN KEY (RestaurantId) REFERENCES Restaurants(RestaurantId)
);


-- 5. Orders Table
CREATE TABLE Orders (
    OrderId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    RestaurantId INT NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    Status NVARCHAR(50) DEFAULT 'Pending',
    OrderDate DATETIME DEFAULT GETDATE(),
    DeliveryDate DATETIME,
    DeliveryAddressId INT NOT NULL,
    PaymentMethod NVARCHAR(50) DEFAULT 'Cash',
    PaymentStatus NVARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (RestaurantId) REFERENCES Restaurants(RestaurantId),
    FOREIGN KEY (DeliveryAddressId) REFERENCES Addresses(AddressId)
);


-- 6. OrderItems Table
CREATE TABLE OrderItems (
    OrderItemId INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT NOT NULL,
    FoodItemId INT NOT NULL,
    FoodItemName NVARCHAR(255) NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    TotalPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    FOREIGN KEY (FoodItemId) REFERENCES FoodItems(ItemId)
);


-- 7. Cart Table (Temporary storage)
CREATE TABLE Cart (
    CartId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL UNIQUE, -- One cart per user
    CartData NVARCHAR(MAX) NOT NULL, -- JSON string to store cart items
    TotalAmount DECIMAL(10,2) DEFAULT 0,
    TotalItems INT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);
