Create database SmartMeterDB;
use SmartMeterDB;

CREATE TABLE [User](  
  UserId         BIGINT IDENTITY PRIMARY KEY,  
  Username       NVARCHAR(100) NOT NULL UNIQUE,  
  PasswordHash   VARBINARY(256) NOT NULL,  
  DisplayName    NVARCHAR(150) NOT NULL,  
  Email          NVARCHAR(200) NULL,  
  Phone          NVARCHAR(30) NULL,  
  LastLoginUtc   DATETIME2(3) NULL,  
  IsActive       BIT NOT NULL DEFAULT 1);
 
 select * from [User]
CREATE TABLE OrgUnit (
  OrgUnitId INT IDENTITY PRIMARY KEY,
  Type VARCHAR(20) NOT NULL CHECK (Type IN ('Zone','Substation','Feeder','DTR')),
  Name NVARCHAR(100) NOT NULL,
  ParentId INT NULL REFERENCES OrgUnit(OrgUnitId)
);
 
CREATE TABLE Tariff (
  TariffId INT IDENTITY PRIMARY KEY,
  Name NVARCHAR(100) NOT NULL,
  EffectiveFrom DATE NOT NULL,
  EffectiveTo DATE NULL,
  BaseRate DECIMAL(18,4) NOT NULL,
  TaxRate DECIMAL(18,4) NOT NULL DEFAULT 0
);
 
CREATE TABLE TodRule (
  TodRuleId      INT IDENTITY PRIMARY KEY,
  TariffId       INT NOT NULL REFERENCES Tariff(TariffId),
  Name           NVARCHAR(50) NOT NULL,
  StartTime      TIME(0) NOT NULL,
  EndTime        TIME(0) NOT NULL,
  RatePerKwh     DECIMAL(18,6) NOT NULL
);
 
CREATE TABLE TariffSlab (
  TariffSlabId   INT IDENTITY PRIMARY KEY,
  TariffId       INT NOT NULL REFERENCES Tariff(TariffId),
  FromKwh        DECIMAL(18,6) NOT NULL,
  ToKwh          DECIMAL(18,6) NOT NULL,
  RatePerKwh     DECIMAL(18,6) NOT NULL,
  CONSTRAINT CK_TariffSlab_Range CHECK (FromKwh >= 0 AND ToKwh > FromKwh)
);
 
CREATE TABLE Consumer (
  ConsumerId BIGINT IDENTITY PRIMARY KEY,
  Name NVARCHAR(200) NOT NULL,
  Address NVARCHAR(500) NULL,
  Phone NVARCHAR(30) NULL,
  Email NVARCHAR(200) NULL,
  OrgUnitId INT NOT NULL REFERENCES OrgUnit(OrgUnitId),
  TariffId INT NOT NULL REFERENCES Tariff(TariffId),
  Status VARCHAR(20) NOT NULL DEFAULT 'Active' CHECK (Status IN ('Active','Inactive')),
  CreatedAt DATETIME2(3) NOT NULL DEFAULT SYSUTCDATETIME(),
  CreatedBy NVARCHAR(100) NOT NULL DEFAULT 'system',
  UpdatedAt DATETIME2(3) NULL,
  UpdatedBy NVARCHAR(100) NULL
);
 
CREATE TABLE Meter (
  MeterSerialNo NVARCHAR(50) NOT NULL PRIMARY KEY,
  IpAddress NVARCHAR(45) NOT NULL,
  ICCID NVARCHAR(30) NOT NULL,
  IMSI NVARCHAR(30) NOT NULL,
  Manufacturer NVARCHAR(100) NOT NULL,
  Firmware NVARCHAR(50) NULL,
  Category NVARCHAR(50) NOT NULL,
  InstallTsUtc DATETIME2(3) NOT NULL,
  Status VARCHAR(20) NOT NULL DEFAULT 'Active'
           CHECK (Status IN ('Active','Inactive','Decommissioned')),
  ConsumerId BIGINT NULL REFERENCES Consumer(ConsumerId)
);

-- Insert into OrgUnit (hierarchical structure)
INSERT INTO OrgUnit (Type, Name, ParentId) VALUES
('Zone', 'North Zone', NULL),
('Substation', 'Substation A', 1),
('Feeder', 'Feeder Line 1', 2),
('DTR', 'Distribution Transformer 1', 3),
('Zone', 'South Zone', NULL);

-- Insert into Tariff
INSERT INTO Tariff (Name, EffectiveFrom, EffectiveTo, BaseRate, TaxRate) VALUES
('Residential Basic', '2024-01-01', '2024-12-31', 4.50, 0.18),
('Commercial HT', '2024-01-01', '2024-12-31', 6.75, 0.18),
('Industrial LT', '2024-01-01', '2024-12-31', 5.25, 0.18),
('Agricultural', '2024-01-01', '2024-12-31', 3.20, 0.12),
('Residential Premium', '2024-01-01', '2024-12-31', 5.80, 0.18);

-- Insert into TodRule (Time-of-Day pricing)
INSERT INTO TodRule (TariffId, Name, StartTime, EndTime, RatePerKwh) VALUES
(1, 'Peak Hours', '18:00:00', '22:00:00', 6.25),
(1, 'Off-Peak', '22:00:00', '06:00:00', 3.75),
(2, 'Commercial Peak', '09:00:00', '18:00:00', 8.50),
(3, 'Industrial Normal', '06:00:00', '18:00:00', 6.00),
(4, 'Agricultural Flat', '00:00:00', '23:59:59', 3.20);

-- Insert into TariffSlab (slab-based pricing)
INSERT INTO TariffSlab (TariffId, FromKwh, ToKwh, RatePerKwh) VALUES
(1, 0, 100, 4.00),
(1, 100, 200, 5.00),
(1, 200, 300, 6.00),
(1, 300, 400, 7.00),
(1, 400, 999999, 8.00);

-- Insert into Consumer
INSERT INTO Consumer (Name, Address, Phone, Email, OrgUnitId, TariffId, Status) VALUES
('Rajesh Kumar', '123 Main St, Delhi', '9876543210', 'rajesh@email.com', 3, 1, 'Active'),
('Priya Sharma', '456 Park Ave, Mumbai', '9876543211', 'priya@email.com', 3, 1, 'Active'),
('Tech Solutions Ltd', '789 Business Park, Bangalore', '9876543212', 'accounts@techsolutions.com', 2, 2, 'Active'),
('Metal Works Inc', '321 Industrial Area, Chennai', '9876543213', 'info@metalworks.com', 4, 3, 'Active'),
('Green Farms', '654 Rural Road, Punjab', '9876543214', 'greenfarms@email.com', 5, 4, 'Active');

-- Insert into Meter
INSERT INTO Meter (MeterSerialNo, IpAddress, ICCID, IMSI, Manufacturer, Firmware, Category, InstallTsUtc, Status, ConsumerId) VALUES
('MET0012024', '192.168.1.101', '89310410101123456789', '404011234567890', 'L&T', 'v2.1.5', 'Single Phase', '2024-01-15 10:30:00', 'Active', 1),
('MET0022024', '192.168.1.102', '89310410101123456790', '404011234567891', 'HPL', 'v1.8.2', 'Single Phase', '2024-01-16 11:15:00', 'Active', 2),
('MET0032024', '192.168.1.103', '89310410101123456791', '404011234567892', 'Schneider', 'v3.0.1', 'Three Phase', '2024-01-17 09:45:00', 'Active', 3),
('MET0042024', '192.168.1.104', '89310410101123456792', '404011234567893', 'ABB', 'v2.5.3', 'Three Phase', '2024-01-18 14:20:00', 'Active', 4),
('MET0052024', '192.168.1.105', '89310410101123456793', '404011234567894', 'L&T', 'v2.1.4', 'Single Phase', '2024-01-19 16:10:00', 'Active', 5);


--List all active users
--Show all consumers with their tariff names
--Count total meters by status
--Show all ToD rules for a given Tariff name
--Get top 5 most recently installed meters
--List consumers without an assigned meter
--Find tariffs that have expired

select * from [user] where  IsActive = 1;

SELECT 
    c.ConsumerId,
    c.Name AS ConsumerName,
    c.Phone,
    c.Email,
    c.Status AS ConsumerStatus,
    t.Name AS TariffName,
    CONCAT('₹', t.BaseRate) AS BaseRate,
    CONCAT(t.TaxRate * 100, '%') AS TaxRate,
    FORMAT(t.EffectiveFrom, 'dd-MMM-yyyy') AS EffectiveFrom,
    FORMAT(t.EffectiveTo, 'dd-MMM-yyyy') AS EffectiveTo
FROM Consumer c
INNER JOIN Tariff t ON c.TariffId = t.TariffId
ORDER BY c.ConsumerId;

SELECT 
    Status,
    COUNT(*) AS MeterCount
FROM Meter
GROUP BY Status
ORDER BY MeterCount DESC; 

select *  FROM Tariff
WHERE EffectiveTo < CAST(GETDATE() AS DATE)
ORDER BY EffectiveTo DESC;


-- Top 5 most recently installed meters
SELECT TOP 5
    MeterSerialNo,
    IpAddress,
    Manufacturer,
    Category,
    FORMAT(InstallTsUtc, 'dd-MMM-yyyy HH:mm') AS InstallDateTime,
    Status,
    ConsumerId
FROM Meter
ORDER BY InstallTsUtc DESC;



------- Read about recursive CTE -------

-- 1. Index on Email (for lookups and uniqueness if needed)
CREATE INDEX IX_User_Email 
ON [User] (Email);

-- 2. Index on IsActive + other frequently filtered columns (composite)
CREATE INDEX IX_User_IsActive_LastLogin 
ON [User] (IsActive, LastLoginUtc);

-- 3. Index on DisplayName (for search and sorting)
CREATE INDEX IX_User_DisplayName 
ON [User] (DisplayName);

Drop Index IX_User_DisplayName on [User];
-- 4. Covering index for active user queries
CREATE INDEX IX_User_ActiveCovering 
ON [User] (IsActive)
INCLUDE (UserId, Username, DisplayName, Email, LastLoginUtc);

-- 5. Index on Phone if frequently searched
CREATE INDEX IX_User_Phone 
ON [User] (Phone);

EXEC sp_helpindex '[User]';

SET STATISTICS TIME ON;
select * from [User] where UserId = 178;

Create Index IX_User_name on [User] (Username);
INSERT INTO [User] (Username, PasswordHash, DisplayName, Email, Phone, LastLoginUtc, IsActive)
VALUES ('person2001',0x2DD6E855B96CF9BB5A34ABCD89C1BC88766A68F39673E956A0CDA67283333 , 
'Test User 2001', 'user2001@example.com', '+1-555-2001', NULL,1);

DROP INDEX IF EXISTS IX_Users_Email ON Users;


CREATE VIEW vw_ActiveUsers
AS
SELECT 
    UserId,
    Username,
    DisplayName,
    Email,
    LastLoginUtc
FROM [User]
WHERE IsActive = 1;


SELECT * FROM vw_ActiveUsers;

-- Filter the view
SELECT UserId, Username, Email 
FROM vw_ActiveUsers 
WHERE LastLoginUtc > '2023-01-01';