create Database Smartmeter;
use  Smartmeter;


create table Customers (CustomerId int primary key, Cust_Name varchar(50),
	Address varchar(50), Region  varchar(50));
create table SmartMeterReadings (MeterId int primary key, CustomerId int, Location varchar(50),
	InstalledDate date, ReadingDateTime time, EnergyConsumed float, foreign key(CustomerId) references Customers (CustomerId));

alter table SmartMeterReadings alter column ReadingDateTime datetime;

insert into Customers values(1, 'Gopal', 'Ballia', 'North'), (2, 'Mantu', 'Jamshedpur', 'North'),
 (3, 'Tejas', 'Ranchi', 'East'), (4, 'Dharmesh', 'Varanasi', 'West'), (5, 'Shashi', 'Hyderabad', 'South');

insert into SmartMeterReadings values (101, 1, 'Rooftop', '2024-01-03', '2024-02-15 09:00:00', 46);
insert into SmartMeterReadings values (102, 1, 'Basement', '2023-06-03', '2024-01-15 06:00:00', 40),
(103, 3, 'Rooftop', '2024-07-12', '2024-05-15 10:00:00', 76),(104, 2, 'Basement', '2024-10-03', '2024-12-15 06:00:00', 6),
(105, 5, 'Basement', '2025-03-03', '2025-02-09 11:00:00', 33);
insert into SmartMeterReadings values (106, 1, 'Rooftop', '2025-01-03', '2025-02-15 09:00:00', 46);

select * from Customers;
select * from SmartMeterReadings;


-- Query 1 --
select MeterId, ReadingDateTime, EnergyConsumed from SmartMeterReadings  where (EnergyConsumed between 10 and 50) and 
 (ReadingDateTime between '2024-01-01' and '2024-12-31') and InstalledDate < ('2024-06-30');

 -- Quert 2 --
 select CustomerId, avg(EnergyConsumed) as AvgEnergyConsumed, max(EnergyConsumed) as MaxEnergyConsumed from 
  SmartMeterReadings where InstalledDate >'2024-12-31' group by CustomerId;
 

