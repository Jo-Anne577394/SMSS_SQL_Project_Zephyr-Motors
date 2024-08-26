USE master; 

CREATE DATABASE ZephyrMotors 
ON PRIMARY 
( 
NAME = 'ZephyrMotorsFile', 
FILENAME = 'C:\SQLDATA\ZephyrMotorsFile1.mdf', 
SIZE = 100MB, 
MAXSIZE = 10GB, --The max size should be a large amount of storage, seeing as the company will generate large amounts of records each day 
FILEGROWTH = 10% 
) 

LOG ON 
( 
NAME = 'ZephyrMotorsLogFile', 
FILENAME = 'C:\SQLLOG\ZephyrMotorsLogFile1.ldf', 
SIZE = 100MB, 
MAXSIZE = 10GB, -- 
FILEGROWTH = 10%  
) 

GO

USE ZephyrMotors; 
GO 
 
CREATE TABLE SupplierAddress 
( 
AddressID INT IDENTITY(1, 1) PRIMARY KEY, 
City VARCHAR(25) NOT NULL, 
Province VARCHAR(25) NOT NULL, 
PostalCode VARCHAR(4) NOT NULL 
) 
GO 
 
CREATE TABLE CustomerAddress 
( 
AddressID INT IDENTITY(1, 1) PRIMARY KEY, 
City VARCHAR(25) NOT NULL, 
Province VARCHAR(25) NOT NULL, 
PostalCode VARCHAR(4) NOT NULL 
) 
GO 
 
CREATE TABLE EmployeeAddress 
( 
AddressID INT IDENTITY(1, 1) PRIMARY KEY, 
City VARCHAR(25) NOT NULL, 
Province VARCHAR(25) NOT NULL, 
PostalCode VARCHAR(4) NOT NULL 
) 
GO 
 
CREATE TABLE Supplier 
( 
SupplierID INT IDENTITY(1, 1) PRIMARY KEY, 
[Name] VARCHAR(25) NOT NULL, 
AddressID INT NOT NULL FOREIGN KEY REFERENCES SupplierAddress(AddressID), 
Phone VARCHAR(10) NOT NULL 
) 
GO 
 
CREATE TABLE Category 
( 
CategoryID INT IDENTITY(1, 1) PRIMARY KEY, 
[Type] VARCHAR(25) NOT NULL, 
[Name] VARCHAR(25) NOT NULL DEFAULT 'Unassigned' 
) 
GO 
 
CREATE TABLE Product 
( 
ProductID INT IDENTITY(1, 1) PRIMARY KEY, 
[Name] VARCHAR(50) NOT NULL, 
CategoryID INT NOT NULL FOREIGN KEY REFERENCES Category(CategoryID), 
UnitPrice MONEY DEFAULT 0, 
UnitsInStock SMALLINT DEFAULT 0, 
Discontinued BIT NOT NULL DEFAULT 0, 
SupplierID INT NOT NULL FOREIGN KEY REFERENCES Supplier(SupplierID) 
) 
GO 
 
CREATE TABLE Department 
( 
DepartmentID INT IDENTITY(1, 1) PRIMARY KEY, 
[Name] VARCHAR(25) NOT NULL 
) 
GO 
 
CREATE TABLE Branch 
( 
BranchID INT IDENTITY(1, 1) PRIMARY KEY, 
[Name] VARCHAR(25) NOT NULL, 
[Type] VARCHAR(25) NOT NULL, 
[Location] VARCHAR(100) NOT NULL, 
Province VARCHAR(25) NOT NULL 
) 
GO 
 
CREATE TABLE Employee 
( 
EmployeeID INT IDENTITY(1, 1) PRIMARY KEY, 
FirstName VARCHAR(25) NOT NULL, 
LastName VARCHAR(25) NOT NULL, 
Title VARCHAR(5) NULL DEFAULT '', 
JobTitle VARCHAR(25) NOT NULL, 
BirthDate DATE NOT NULL, 
HireDate DATE NOT NULL, 
PhoneNumber VARCHAR(10) NOT NULL, 
HighestEducation VARCHAR(50) NOT NULL, 
ReportsTo SMALLINT NOT NULL, 
AddressID INT NOT NULL FOREIGN KEY REFERENCES EmployeeAddress(AddressID), 
DepartmentID INT NOT NULL FOREIGN KEY REFERENCES Department(DepartmentID), 
BranchID INT NOT NULL FOREIGN KEY REFERENCES Branch(BranchID)  
) 
GO 
 
CREATE TABLE Customer 
( 
CustomerID INT IDENTITY(1, 1) PRIMARY KEY, 
[Type] VARCHAR(15) NOT NULL, 
[Name] VARCHAR(25) NOT NULL, 
PhoneNumber VARCHAR(10) NOT NULL, 
AddressID INT NOT NULL FOREIGN KEY REFERENCES CustomerAddress(AddressID) 
) 
GO 
 
CREATE TABLE Sale 
( 
SalesID INT IDENTITY(1, 1) PRIMARY KEY, 
EmployeeID INT NOT NULL FOREIGN KEY REFERENCES Employee(EmployeeID), 
CustomerID INT NOT NULL FOREIGN KEY REFERENCES Customer(CustomerID), 
SalesDate DATE NOT NULL 
) 
GO 
 
CREATE TABLE ProductSale 
( 
SalesID INT NOT NULL FOREIGN KEY REFERENCES Sale(SalesID), 
ProductID INT NOT NULL FOREIGN KEY REFERENCES Product(ProductID), 
SalesPrice MONEY DEFAULT 0, 
Quantity INT NOT NULL DEFAULT 1, 
Discount DECIMAL(6, 4) NOT NULL DEFAULT 0, 
Total AS (SalesPrice * Quantity * (1 - Discount)), 
CommissionPercentage DECIMAL(6, 4) NOT NULL DEFAULT 0.025, 
Commission AS ((SalesPrice * Quantity * (1 - Discount)) * CommissionPercentage), 
PaymentType VARCHAR(10) NOT NULL, 
PRIMARY KEY (SalesID, ProductID) 
) 
GO 

USE ZephyrMotors; 
GO 
 
CREATE TABLE SupplierAddress 
( 
AddressID INT IDENTITY(1, 1) PRIMARY KEY, 
City VARCHAR(25) NOT NULL, 
Province VARCHAR(25) NOT NULL, 
PostalCode VARCHAR(4) NOT NULL 
) 
GO 
 
CREATE TABLE CustomerAddress 
( 
AddressID INT IDENTITY(1, 1) PRIMARY KEY, 
City VARCHAR(25) NOT NULL, 
Province VARCHAR(25) NOT NULL, 
PostalCode VARCHAR(4) NOT NULL 
) 
GO 
 
CREATE TABLE EmployeeAddress 
( 
AddressID INT IDENTITY(1, 1) PRIMARY KEY, 
City VARCHAR(25) NOT NULL, 
Province VARCHAR(25) NOT NULL, 
PostalCode VARCHAR(4) NOT NULL 
) 
GO 
 
CREATE TABLE Supplier 
( 
SupplierID INT IDENTITY(1, 1) PRIMARY KEY, 
[Name] VARCHAR(25) NOT NULL, 
AddressID INT NOT NULL FOREIGN KEY REFERENCES SupplierAddress(AddressID), 
Phone VARCHAR(10) NOT NULL 
) 
GO 
 
CREATE TABLE Category 
( 
CategoryID INT IDENTITY(1, 1) PRIMARY KEY, 
[Type] VARCHAR(25) NOT NULL, 
[Name] VARCHAR(25) NOT NULL DEFAULT 'Unassigned' 
) 
GO 
 
CREATE TABLE Product 
( 
ProductID INT IDENTITY(1, 1) PRIMARY KEY, 
[Name] VARCHAR(50) NOT NULL, 
CategoryID INT NOT NULL FOREIGN KEY REFERENCES Category(CategoryID), 
UnitPrice MONEY DEFAULT 0, 
UnitsInStock SMALLINT DEFAULT 0, 
Discontinued BIT NOT NULL DEFAULT 0, 
SupplierID INT NOT NULL FOREIGN KEY REFERENCES Supplier(SupplierID) 
) 
GO 
 
CREATE TABLE Department 
( 
DepartmentID INT IDENTITY(1, 1) PRIMARY KEY, 
[Name] VARCHAR(25) NOT NULL 
) 
GO 
 
CREATE TABLE Branch 
( 
BranchID INT IDENTITY(1, 1) PRIMARY KEY, 
[Name] VARCHAR(25) NOT NULL, 
[Type] VARCHAR(25) NOT NULL, 
[Location] VARCHAR(100) NOT NULL, 
Province VARCHAR(25) NOT NULL 
) 
GO 
 
CREATE TABLE Employee 
( 
EmployeeID INT IDENTITY(1, 1) PRIMARY KEY, 
FirstName VARCHAR(25) NOT NULL, 
LastName VARCHAR(25) NOT NULL, 
Title VARCHAR(5) NULL DEFAULT '', 
JobTitle VARCHAR(25) NOT NULL, 
BirthDate DATE NOT NULL, 
HireDate DATE NOT NULL, 
PhoneNumber VARCHAR(10) NOT NULL, 
HighestEducation VARCHAR(50) NOT NULL, 
ReportsTo SMALLINT NOT NULL, 
AddressID INT NOT NULL FOREIGN KEY REFERENCES EmployeeAddress(AddressID), 
DepartmentID INT NOT NULL FOREIGN KEY REFERENCES Department(DepartmentID), 
BranchID INT NOT NULL FOREIGN KEY REFERENCES Branch(BranchID)  
) 
GO 
 
CREATE TABLE Customer 
( 
CustomerID INT IDENTITY(1, 1) PRIMARY KEY, 
[Type] VARCHAR(15) NOT NULL, 
[Name] VARCHAR(25) NOT NULL, 
PhoneNumber VARCHAR(10) NOT NULL, 
AddressID INT NOT NULL FOREIGN KEY REFERENCES CustomerAddress(AddressID) 
) 
GO 
 
CREATE TABLE Sale 
( 
SalesID INT IDENTITY(1, 1) PRIMARY KEY, 
EmployeeID INT NOT NULL FOREIGN KEY REFERENCES Employee(EmployeeID), 
CustomerID INT NOT NULL FOREIGN KEY REFERENCES Customer(CustomerID), 
SalesDate DATE NOT NULL 
) 
GO 
 
CREATE TABLE ProductSale 
( 
SalesID INT NOT NULL FOREIGN KEY REFERENCES Sale(SalesID), 
ProductID INT NOT NULL FOREIGN KEY REFERENCES Product(ProductID), 
SalesPrice MONEY DEFAULT 0, 
Quantity INT NOT NULL DEFAULT 1, 
Discount DECIMAL(6, 4) NOT NULL DEFAULT 0, 
Total AS (SalesPrice * Quantity * (1 - Discount)), 
CommissionPercentage DECIMAL(6, 4) NOT NULL DEFAULT 0.025, 
Commission AS ((SalesPrice * Quantity * (1 - Discount)) * CommissionPercentage), 
PaymentType VARCHAR(10) NOT NULL, 
PRIMARY KEY (SalesID, ProductID) 
) 
GO 

USE ZephyrMotors; 

GO 

INSERT INTO Branch ([Name], [Type], [Location], Province) 
VALUES  
('Bright Future Branch', 'Retail', 'fish hoek', 'western cape'), 
('Emerald Gardens Branch', 'Head office', 'Johannesburg', 'Gauteng'), 
('Clear Vision Branch', 'Retail', 'Mahikeng', 'North West'), 
('Rising Sun Branch', 'Retail', 'Durban', 'KwaZulu-Natal'), 
('Harmony Way Branch', 'Retail', 'Port Elizabeth', 'Eastern Cape'), 
('Pacific Crest Branch', 'Retail', 'Bloemfontein', 'Free State'), 
('Infinite Horizons Branch', 'Retail', 'Kimberley', 'Northern Cape'), 
('Royal Oak Branch', 'Retail', 'Nelspruit', 'Mpumalanga'), 
('Stellar Heights Branch', 'Retail', 'Polokwane', 'Limpopo'), 
('Phoenix Rise Branch', 'Retail', 'Pietermaritzburg', 'KwaZulu-Natal'); 

GO 
 
INSERT INTO Department ([Name]) 
VALUES  
('Sales'), 
('Marketing'), 
('Finance'), 
('Human Resources'), 
('IT'), 
('Research and Development'), 
('Customer Service'), 
('Operations'), 
('Purchasing'), 
('Quality Control'); 

GO 

INSERT INTO EmployeeAddress (City, Province, PostalCode) 
VALUES  
('Johannesburg', 'Gauteng', '2196'), 
('Cape Town', 'Western Cape', '8001'), 
('Durban', 'KwaZulu-Natal', '4001'), 
('Port Elizabeth', 'Eastern Cape', '6001'), 
('Bloemfontein', 'Free State', '9301'), 
('Kimberley', 'Northern Cape', '8301'), 
('Nelspruit', 'Mpumalanga', '1200'), 
('Polokwane', 'Limpopo', '0700'), 
('Mahikeng', 'North West', '2745'), 
('Pietermaritzburg', 'KwaZulu-Natal', '3200'), 
('East London', 'Eastern Cape', '5200'), 
('Pretoria', 'Gauteng', '0001'), 
('Middelburg', 'Mpumalanga', '1050'), 
('George', 'Western Cape', '6530'), 
('Upington', 'Northern Cape', '8801'), 
('Johannesburg', 'Gauteng', '2146'), 
('Cape Town', 'Eastern Cape', '2136'), 
('Durban', 'Mpumalanga', '3126'), 
('George', 'Western Cape', '5116'), 
('Cape Town', 'Limpopo', '1156'), 
('Johannesburg', 'Eastern Cape', '2196'), 
('George', 'Gauteng', '5206'), 
('Johannesburg', 'Mpumalanga', '8196'), 
('Durban', 'Western Cape', '5126'), 
('Cape Town', 'Gauteng', '6197'), 
('Johannesburg', 'Eastern Cape', '9199'), 
('Port Elizabeth', 'Limpopo', '1191'), 
('Port Elizabeth', 'Gauteng', '2396'), 
('Johannesburg', 'Western Cape', '1156'), 
('Cape Town', 'Mpumalanga', '5296'), 
('Johannesburg', 'Gauteng', '2755'), 
('Port Elizabeth', 'Eastern Cape', '1843'), 
('Port Elizabeth', 'Limpopo', '2122'), 
('Johannesburg', 'Western Cape', '7176'), 
('Port Elizabeth', 'Gauteng', '9126'); 

GO 

INSERT INTO Employee (FirstName, LastName, Title, JobTitle, BirthDate, HireDate, PhoneNumber, HighestEducation, ReportsTo, AddressID, DepartmentID, BranchID) 
VALUES  
('John', 'Smith', 'Mr.', 'Sales Representative', '1990-05-15', '2020-01-01', '0823456789', 'Bachelor of Commerce', 0, 1, 1, 1), 
('Jane', 'Doe', 'Ms.', 'Marketing Manager', '1985-08-20', '2019-06-01', '0834567890', 'Master of Business Administration', 0, 2, 2, 2), 
('David', 'Jones', 'Mr.', 'Financial Analyst', '1992-02-10', '2021-03-15', '0845678901', 'Bachelor of Business Science', 1, 3, 3, 3), 
('Mary', 'Johnson', 'Ms.', 'sales person', '1988-11-02', '2018-02-01', '0856789012', 'Bachelor of Arts', 1, 4, 4, 4), 
('Robert', 'Williams', 'Mr.', 'IT Specialist', '1991-06-30', '2022-02-01', '0867890123', 'Bachelor of Science in Computer Science', 2, 5, 5, 5), 
('Elizabeth', 'Brown', 'Ms.', 'Research Analyst', '1994-01-21', '2019-01-01', '0878901234', 'Master of Science in Mathematics', 2, 6, 6, 6), 
('Michael', 'Davis', 'Mr.', 'Customer support', '1993-09-18', '2020-08-01', '0889012345', 'Bachelor of Business Administration', 3, 7, 7, 7), 
('Amanda', 'Wilson', 'Ms.', 'Operations Manager', '1987-04-12', '2017-11-01', '0890123456', 'Master of Operations Management', 3, 8, 8, 8), 
('Christopher', 'Moore', 'Mr.', 'Purchasing Coordinator', '1990-12-04', '2021-05-01', '0823456789', 'Bachelor of Commerce', 4, 9, 9, 9), 
('Emily', 'Taylor', 'Ms.', 'Quality Manager', '1995-07-09', '2018-06-01', '0834567890', 'Bachelor of Science in Chemistry', 4, 10, 10, 10), 
('Daniel', 'Anderson', 'Mr.', 'Sales Representative', '1993-03-26', '2020-02-01', '0845678901', 'Bachelor of Commerce', 5, 11, 1, 1), 
('Jessica', 'Thomas', 'Ms.', 'Marketing Coordinator', '1989-10-14', '2019-03-01', '0856789012', 'Bachelor of Business Science', 5, 12, 2, 2), 
('Kevin', 'Lee', 'Mr.', 'Financial Advisor', '1992-05-27', '2021-04-15', '0867890123', 'Bachelor of Business Administration', 6, 13, 3, 3), 
('Emma', 'Johnson', 'Ms.', 'Sales Manager', '1990-03-15', '2018-01-01', '0825552234', 'Bachelor of Business Administration', 0, 14, 4, 1), 
('Daniel', 'Smith', 'Mr.', 'Marketing Manager', '1985-08-28', '2015-06-01', '0832772345', 'Master of Business Administration', 0, 15, 1, 8), 
('Olivia ', 'Patel', 'Ms.', ' Sales Associate', '1998-03-15', '2018-01-01', '0835551234', 'Bachelor of Business Administration', 0, 16, 1, 2), 
('Ethan', 'Gallagher', 'Mr.', 'Sales Representative', '1994-03-15', '2018-01-01', '0825561234', 'Bachelor of Business Administration', 0, 17, 1, 3), 
('Sophia', 'Kim', 'Ms.', 'Account Manager', '1970-03-15', '2018-01-01', '0825451234', 'Bachelor of Business Administration', 0, 18, 1, 4), 
('William', 'Nguyen', 'Mr', 'Business Manager', '1995-03-15', '2018-01-01', '0835551234', 'Bachelor of Business Administration', 0, 19, 1, 5), 
('Charlotte', ' Mitchell', 'Ms.', 'Sales Consultant', '1996-03-15', '2018-01-01', '0825551134', 'Bachelor of Business Administration', 0, 20, 1, 6), 
('Lucas', ' Singh', 'Mr.', 'Sales Representative', '1997-03-15', '2018-01-01', '0825558234', 'Bachelor of Business Administration', 0, 21, 1, 7), 
('Ava', 'Wong', 'Ms.', 'Sales Representative', '1998-03-15', '2018-01-01', '0825551235', 'Bachelor of Business Administration', 0, 22, 1, 8), 
('Mason', 'Johnson', 'Mr.', 'Sales Executive', '1980-03-15', '2018-01-01', '0725551234', 'Bachelor of Business Administration', 0, 23, 1, 9), 
('Mia', ' Rodriguez', 'Ms.', 'Territory Sales Manager', '1975-03-15', '2018-01-01', '0825553234', 'Bachelor of Business Administration', 0, 24, 1, 10), 
('Benjamin', 'Lee', 'Mr.', 'Key Account Manager', '1998-03-15', '2018-01-01', '0825541244', 'Bachelor of Business Administration', 0, 25, 1, 2), 
('Isabella ', ' Davis', 'Ms.', 'Sales Coordinator', '1995-03-15', '2018-01-01', '0813551234', 'Bachelor of Business Administration', 0, 26, 1, 3), 
('Noah', 'Wright', 'Mr.', 'Sales Specialist', '1994-03-15', '2018-01-01', '0824554234', 'Bachelor of Business Administration', 0, 27, 1, 4), 
('Emma', 'Brown', 'Ms.', 'Sales Manager', '1993-03-15', '2018-01-01', '0825551131', 'Bachelor of Business Administration', 0, 28, 1, 5), 
('Jameson', 'Chen', 'Mr.', 'Customer Success Manager', '1992-03-15', '2018-01-01', '0823571234', 'Bachelor of Business Administration', 0, 29, 1, 6), 
('Harper', 'Wilson', 'Mr.', 'Sales Team Leader', '1991-03-15', '2018-01-01', '0845541284', 'Bachelor of Business Administration', 0, 30, 1, 7), 
('Alexander', 'Garcia', 'Ms.', 'Regional Sales Manager', '1988-03-15', '2018-01-01', '0825551336', 'Bachelor of Business Administration', 0, 31, 1, 8), 
('Penelope', 'Jones', 'Ms.', ' Sales Coordinator', '1985-02-15', '2018-01-01', '0814551234', 'Bachelor of Business Administration', 0, 32, 1, 9), 
('Elijah', 'Martinez', 'Mr.', 'Sales Specialist', '1986-03-15', '2018-01-01', '0823551234', 'Bachelor of Business Administration', 0, 33, 1, 10), 
('Abigail', 'Taylor', 'Ms.', 'Account Executive', '1939-03-15', '2018-01-01', '0826551234', 'Bachelor of Business Administration', 0, 34, 1, 3), 
('Daniel', 'Hernandez', 'Mr.', 'Client Manager', '1982-03-15', '2018-01-01', '0827551234', 'Bachelor of Business Administration', 0, 35, 1, 5); 

GO 

INSERT INTO Category ([Type], [Name])  
VALUES 
('Parts', 'Engine'), 
('Parts', 'Transmission'), 
('Parts', 'Brakes'), 
('Parts', 'Suspension'), 
('Parts', 'Electrical'), 
('Parts', 'Exhaust'), 
('Vehicle', 'SUV'), 
('Vehicle', 'Sports cars'), 
('Vehicle', 'Motorcycle'), 
('Vehicle', 'Scooter'), 
('Vehicle', 'Bus'), 
('Vehicle', 'Bakkie'), 
('Vehicle', 'Convertible'); 

GO 

INSERT INTO SupplierAddress (City, Province, PostalCode) 
VALUES  
('Johannesburg', 'Gauteng', '2001'), 
('Cape Town', 'Western Cape', '8000'), 
('Durban', 'KwaZulu-Natal', '4001'), 
('Port Elizabeth', 'Eastern Cape', '6001'), 
('Bloemfontein', 'Free State', '9300'), 
('Kimberley', 'Northern Cape', '8300'), 
('Nelspruit', 'Mpumalanga', '1200'), 
('Polokwane', 'Limpopo', '0700'), 
('Mahikeng', 'North West', '2745'), 
('Pietermaritzburg', 'KwaZulu-Natal', '3200'); 

GO 

INSERT INTO Supplier ([Name], AddressID, Phone) 
VALUES  
('ABC Manufacturing', 1, '0123456789'), 
('XYZ Industries', 2, '0234567891'), 
('JKL Suppliers', 3, '0345678912'), 
('PQR Distributors', 4, '0456789123'), 
('MNO Inc.', 5, '0567891234'), 
('EFG Enterprises', 6, '0678912345'), 
('HIJ Co.', 7, '0789123456'), 
('DEF Ltd.', 8, '0891234567'), 
('GHI Trading', 9, '0902345678'), 
('LMN Corporation', 10, '0123456789'); 

GO 

INSERT INTO Product ([Name], CategoryID, UnitPrice, UnitsInStock, Discontinued, SupplierID) 
VALUES 
('Diesel engine', 1, 50.00, 100, 0, 1), 
('Transmission casing', 2, 35.00, 75, 0, 2), 
('Alternator', 5, 10.00, 150, 0, 3), 
('Shock absorbers', 4, 7500.00, 50, 0, 3), 
('Honda CR-V', 7, 800000.00, 200, 0, 5), 
('Borla ATAK Cat-Back Exhaust System', 6, 150000.00, 25, 0, 3), 
('Lamborghini Huracan', 8, 1000000.00, 30, 0, 8), 
('Electric engines', 1, 85.00, 40, 0, 8), 
('Air Suspension ', 4, 125.00, 100, 0, 9), 
('Brake Rotor ', 3, 200.00, 20, 0, 10), 
('Single exit exhausts', 6, 60.00, 60, 0, 1), 
('Spark plugs', 5, 12.00, 175, 0, 2), 
('Honda Activa', 10, 25000.00, 10, 1, 3), 
('Ford Transit', 11, 150000.00, 30, 0, 4), 
('Toyota RAV4', 7, 170005.00, 20, 0, 1), 
('Vespa Primavera', 10, 500000.00, 75, 0, 6), 
('Ford Ranger', 12, 250000.00, 100, 0, 7), 
('Mazda MX-5 Miata', 13, 100000.00, 50, 1, 8), 
('Toyota Hilux', 12, 75000.00, 60, 0, 9), 
('Porsche 911', 9, 450000.00, 50, 0, 10); 

GO 

INSERT INTO CustomerAddress (City, Province, PostalCode) 
VALUES  
('Johannesburg', 'Gauteng', '2001'), 
('Cape Town', 'Western Cape', '8001'), 
('Durban', 'KwaZulu-Natal', '4001'), 
('Port Elizabeth', 'Eastern Cape', '6001'), 
('Bloemfontein', 'Free State', '9301'), 
('Kimberley', 'Northern Cape', '8301'), 
('Nelspruit', 'Mpumalanga', '1200'), 
('Polokwane', 'Limpopo', '0700'), 
('Mahikeng', 'North West', '2745'), 
('Pietermaritzburg', 'KwaZulu-Natal', '3200'), 
('East London', 'Eastern Cape', '5200'), 
('Pretoria', 'Gauteng', '0001'), 
('Middelburg', 'Mpumalanga', '1050'), 
('George', 'Western Cape', '6530'), 
('Upington', 'Northern Cape', '8801'); 

GO 

INSERT INTO Customer ([Type], [Name], PhoneNumber, AddressID) 
VALUES  
('Individual', 'John Smith', '0123456789', 1), 
('Corporate', 'Acme Inc.', '0234567891', 2), 
('Individual', 'Jane Doe', '0345678912', 3), 
('Corporate', 'Globex Corp.', '0456789123', 4), 
('Individual', 'Bob Johnson', '0567891234', 5), 
('Individual', 'Sarah Williams', '0678912345', 6), 
('Corporate', 'Initech', '0789123456', 7), 
('Individual', 'Michael Davis', '0891234567', 8), 
('Individual', 'Jessica Brown', '0902345678', 9), 
('Corporate', 'Umbrella Corporation', '0913456789', 10), 
('Individual', 'Tom Smith', '0924567891', 11), 
('Individual', 'Emily Johnson', '0935678912', 12), 
('Corporate', 'Wayne Enterprises', '0946789123', 13), 
('Individual', 'Oliver Green', '0957891234', 14), 
('Individual', 'Linda White', '0968912345', 15); 

GO 

INSERT INTO Sale (EmployeeID, CustomerID, SalesDate) VALUES 
(1, 4, '2022-02-15'), 
(1, 8, '2022-04-28'), 
(15, 11, '2022-08-03'), 
(11, 2, '2022-09-20'), 
(15, 5, '2022-01-08'), 
(1, 7, '2022-07-13'), 
(11, 3, '2022-03-17'), 
(11, 15, '2022-11-05'), 
(1, 10, '2022-06-19'), 
(15, 9, '2022-12-25'), 
(11, 1, '2022-10-10'), 
(1, 13, '2022-05-22'), 
(15, 14, '2022-02-28'), 
(11, 6, '2022-09-08'), 
(15, 11, '2022-07-09'), 
(1, 3, '2022-03-16'), 
(1, 12, '2022-05-10'), 
(11, 15, '2022-11-21'), 
(15, 6, '2022-09-03'), 
(11, 8, '2022-12-30'), 
(1, 2, '2022-01-21'), 
(1, 5, '2022-02-18'), 
(15, 13, '2022-06-01'), 
(15, 1, '2022-10-22'), 
(11, 14, '2022-08-12'), 
(1, 4, '2022-03-04'), 
(11, 7, '2022-09-27'), 
(15, 9, '2022-11-14'), 
(1, 12, '2022-06-04'), 
(15, 6, '2022-04-01'), 
(1, 13, '2022-12-10'), 
(16, 1, '2022-01-21'), 
(17, 3, '2022-02-21'), 
(18, 5, '2022-03-21'), 
(19, 8, '2022-04-21'), 
(20, 12, '2022-01-22'), 
(21, 13, '2022-01-01'), 
(22, 14, '2022-11-14'), 
(23, 4, '2022-05-24'), 
(24, 2, '2022-04-11'), 
(25, 8, '2022-02-21'), 
(26, 11, '2022-11-23'), 
(27, 6, '2022-08-21'), 
(28, 9, '2022-07-21'), 
(29, 7, '2022-02-21'), 
(30, 15, '2022-11-14'), 
(31, 12, '2022-11-21'), 
(32, 3, '2022-12-15'), 
(33, 5, '2022-04-11'), 
(34, 13, '2022-08-15'), 
(35, 8, '2022-08-13'); 

GO 

INSERT INTO ProductSale (SalesID, ProductID, SalesPrice, Quantity, Discount, CommissionPercentage, PaymentType) 
VALUES 
(1, 1, 50.00, 2, 0,0.045, 'Credit'), 
(2, 2, 35.00, 1, 0.2, 0.035, 'Debit'), 
(3, 3, 10.00, 3, 0, 0.035, 'Cash'), 
(4, 4, 7500.00, 1, 0.0, 0.025, 'Credit'), 
(5, 5, 800000.00, 1, 0, 0.015, 'Cash'), 
(6, 6, 150000, 1, 0.15, 0.015, 'Debit'), 
(7, 7, 1000000, 1, 0, 0.005, 'Cash'), 
(8, 8, 85, 2, 0, 0.045, 'Credit'), 
(9, 9, 125, 1, 0.05, 0.055, 'Cash'), 
(10, 10, 200, 1, 0, 0.035, 'Debit'), 
(11, 11, 60, 1, 0.1, 0.055, 'Cash'), 
(12, 12, 12, 2, 0.2, 0.065, 'Credit'), 
(13, 13, 25000, 1, 0, 0.025, 'Cash'), 
(14, 14, 150000, 3, 0.15, 0.020, 'Debit'), 
(15, 15, 170005, 2, 0, 0.025, 'Credit'), 
(16, 16, 500000, 1, 0.1, 0.015, 'Cash'), 
(17, 17, 250000, 1, 0, 0.015, 'Debit'), 
(18, 18, 100000, 2, 0.05, 0.012, 'Credit'), 
(19, 19, 75000, 1, 0, 0.015, 'Cash'), 
(20, 20, 450000, 1, 0.1, 0.045, 'Debit'), 
(21, 2, 35, 1, 0, 0.035, 'Credit'), 
(22, 1, 50, 2, 0, 0.045, 'Cash'), 
(23, 5, 800000, 1, 0.1, 0.015, 'Debit'), 
(24, 3, 10, 3, 0.2, 0.035, 'Credit'), 
(25, 4, 7500, 1, 0, 0.025, 'Cash'), 
(26, 5, 800000, 1, 0.15, 0.015, 'Debit'), 
(27, 6, 150000, 2, 0, 0.015, 'Credit'), 
(28, 7, 1000000, 1, 0, 0.005, 'Cash'), 
(29, 5, 800000, 2, 0, 0.015, 'Credit'), 
(30, 12, 12, 1, 0.2, 0.065, 'Debit'), 
(31, 5, 800000, 2, 0, 0.015, 'Credit'), 
(32, 5, 400000, 1, 0, 0.015, 'Cash'), 
(33, 3, 10.00, 2, 0, 0.015, 'Debit'), 
(34, 2, 35, 1, 0, 0.015, 'Credit'), 
(35, 1, 25, 2, 0, 0.015, 'Cash'), 
(36, 5, 800000, 2, 0, 0.015, 'Debit'), 
(37, 4, 15000, 1, 0, 0.015, 'Credit'), 
(38, 7, 1000000, 1, 0, 0.005, 'Cash'), 
(39, 8, 85, 1, 0, 0.045, 'Credit'), 
(40, 9, 250, 2, 0, 0.025, 'Debit'), 
(41, 11, 120, 2, 0, 0.025, 'Credit'), 
(42, 5, 800000, 1, 0, 0.015, 'Cash'), 
(43, 7, 1000000, 1, 0, 0.005, 'Credit'), 
(44, 4, 150000, 2, 0, 0.015, 'Debit'), 
(45, 6, 300000, 2, 0, 0.015, 'Credit'), 
(46, 5, 150000, 1, 0, 0.015, 'Cash'), 
(47, 9, 125, 1, 0, 0.015, 'Credit'), 
(48, 13, 25000, 2, 0, 0.015, 'Debit'), 
(49, 12, 12, 1, 0, 0.015, 'Credit'), 
(50, 16, 1000000, 2, 0, 0.015, 'Cash'), 
(51, 17, 500000, 2, 0, 0.015, 'Debit'); 

GO 

--Query 1: This query will show the total sales per branch
USE ZephyrMotors; 
GO 

SELECT b.Name AS BranchName, COUNT(*) AS TotalSales 
FROM Sale s 
INNER JOIN Employee e ON s.EmployeeID = e.EmployeeID 
INNER JOIN Branch b ON e.BranchID = b.BranchID 
GROUP BY b.Name; 
GO

--Query 2: This query will show the total sales per product
USE ZephyrMotors;  
GO  

SELECT p.Name AS ProductName, SUM(ps.Total) AS TotalSales 
FROM ProductSale ps 
INNER JOIN Product p ON ps.ProductID = p.ProductID 
GROUP BY p.Name 
ORDER BY TotalSales DESC; 
GO

--Query 3: Average age of employees per department will be displayed
USE ZephyrMotors; 
GO 

SELECT d.[Name] AS Department, AVG(DATEDIFF(yy,e.BirthDate, GETDATE())) AS [Average age of Employees]  
--The DATEDIFF will determin the age of each employee and the AVG will determine the average of the ages 
FROM Department d 
JOIN Employee e ON d.DepartmentID = e.DepartmentID 
GROUP BY d.[Name] --This will group the average ages according to the department 
GO 

--Query 4: Total amount of products sold per category, including the total sale price
USE ZephyrMotors; 
GO 
 
SELECT c.[Name], COUNT(p.CategoryID) AS [Total Per Category], SUM(ps.Total) AS [Total Sales] 
FROM Category c 
JOIN Product p ON c.CategoryID = p.CategoryID --This joins the Category table with the Product table 
JOIN ProductSale ps ON p.ProductID = ps.ProductID --This joins the ProductSale tabel with the Product table 
GROUP BY c.[Name]; --This shows the totals per category 
GO 

--Insert: This inserts a new product in the Product table 
USE ZephyrMotors;  
GO 

DECLARE @ProductName VARCHAR(50) 
DECLARE @CategoryID INT 
DECLARE @UnitPrice MONEY 
DECLARE @UnitsInStock SMALLINT 
DECLARE @Discontinued BIT 
DECLARE @SupplierID INT;
 
SET @ProductName = (SELECT CONVERT(VARCHAR(50),(SELECT 'testproduct')))-- 'Enter product name: ' 
PRINT 'New product name: ' + @ProductName 


SET @CategoryID = (SELECT CONVERT(INT, (SELECT '5')))-- 'Enter category ID: ' 
PRINT 'New category ID: ' + CAST(@CategoryID AS VARCHAR(10)) 

SET @UnitPrice = (SELECT CONVERT(MONEY, (SELECT '20')))-- 'Enter unit price: ' 
PRINT 'New unit price: ' + CAST(@UnitPrice AS VARCHAR(20)) 

SET @UnitsInStock = (SELECT CONVERT(SMALLINT, (SELECT '12')))-- 'Enter units in stock: ' 
PRINT 'New units in stock: ' + CAST(@UnitsInStock AS VARCHAR(10)) 

SET @Discontinued = (SELECT CONVERT(BIT, (SELECT '1')))-- 'Enter 1 for discontinued or 0 for not discontinued: ' 
if CAST(@Discontinued AS VARCHAR(10)) = 1 
PRINT 'New discontinued status: ' + ' Discontinued' 

ELSE if CAST(@Discontinued AS VARCHAR(10)) = 0 
PRINT 'New discontinued status:' + 'Not Discontiued' 

SET @SupplierID = (SELECT CONVERT(INT, (SELECT '4')))-- 'Enter supplier ID: ' 
PRINT 'New supplier ID: ' + CAST(@SupplierID AS VARCHAR(10)) 

INSERT INTO Product ([Name], CategoryID, UnitPrice, UnitsInStock, Discontinued, SupplierID) 
VALUES (@ProductName, @CategoryID, @UnitPrice, @UnitsInStock, @Discontinued, @SupplierID); 

GO 

--Update: Update employee address 
USE ZephyrMotors; 
GO 

UPDATE EmployeeAddress 
SET City = 'Durban', Province = 'KZN', PostalCode = '4000' 
WHERE AddressID = 1; 

--Delete: Remove employee from the Employee table 

USE ZephyrMotors; 
DELETE FROM Employee 
WHERE EmployeeID = 4; 

GO 

--View: Displays all of the information about each sale
USE ZephyrMotors; 
GO 

CREATE VIEW vw_SalesInformation 
AS 
SELECT s.SalesID, e.FirstName + e.LastName AS Employee, c.[Name] AS Customer, s.SalesDate, p.[Name] AS Product, ps.Quantity, ps.Total  
--All the columns that I want to retrieve to the view 
FROM Sale s 
JOIN Employee e ON s.EmployeeID = e.EmployeeID 
JOIN Customer c on s.CustomerID = c.CustomerID  
JOIN ProductSale ps ON s.SalesID = ps.SalesID 
JOIN Product p ON ps.ProductID = p.ProductID 
 
GO 
SELECT*FROM vw_SalesInformation;  
--All columns as specified inside the view will be displayed 
GO 

--Stored Procedure: To insert new sales into the database
USE ZephyrMotors; 
GO 

CREATE PROCEDURE sp_NewSale 
@sEmployeeID INT, 
@sCustomerID INT, 
@sSalesDate Date, 
@psProductID INT, 
@psQuantity INT, 
@psDiscount DECIMAL(6, 4), 
@psCommissionPercentage DECIMAL(6,4), 
@psPaymentType VARCHAR(10) --These are all the needed information about the sale 

AS 
INSERT INTO Sale(EmployeeID, CustomerID, SalesDate) 
VALUES(@sEmployeeID, @sCustomerID, @sSalesDate); --This adds the relavant information to the Sale table 

DECLARE @psSalesID INT; --This is used to retrieve the SalesID from the currently added sale 
SELECT @psSalesID = (SELECT SalesID FROM Sale WHERE (EmployeeID = @sEmployeeID) AND (CustomerID = @sCustomerID) AND (SalesDate = @sSalesDate)); 

DECLARE @psSalesPrice MONEY; --This is used to retrieve the products price 
SELECT @psSalesPrice = (SELECT UnitPrice FROM Product WHERE ProductID = @psProductID); 

INSERT INTO ProductSale(SalesID, ProductID, SalesPrice, Quantity, Discount, CommissionPercentage, PaymentType) --Here the sale is also added to the ProductSale table 
VALUES(@psSalesID, @psProductID, @psSalesPrice, @psQuantity, @psDiscount, @psCommissionPercentage, @psPaymentType); 

UPDATE Product --The sold stock must then be suntracted from the UnitsInStock column 
SET UnitsInStock = UnitsInStock - @psQuantity 
WHERE ProductID = @psProductID; 

GO 

EXECUTE sp_NewSale 1, 1, '2023-04-04', 1, 2, 0, 0.02, 'Cash'; --Here is a example 
GO 


--Function: To Return the number of Products in stock per product 

USE ZephyrMotors; 
GO 

CREATE FUNCTION dbo.fn_YearsEmployeed 
( 
@DateHired DATE --This retrieves the date the employees were hired 
) 
RETURNS INT 

AS 
BEGIN 
DECLARE @Years INT; 
SET @Years = DATEDIFF(yy, @DateHired, GETDATE()); --This will set the years to the number of years between the date the employee was hired and the current date 
RETURN @Years; 
END 

GO 
SELECT FirstName +' '+ LastName AS Employee, dbo.fn_YearsEmployeed(HireDate) AS [Years Employeed]  
-- This will display the full name of the employee as well as the number of years the employee has worked at the company 
FROM Employee; 

GO

/*Trigger: This trigger will be placed on the insert statement for the employee table and 
check to see that when adding the new employee, that the are at least 16 years old. */
USE ZephyrMotors; 
GO

Create TRIGGER CheckEmployeeAge 
On Employee 
FOR INSERT 
AS 
BEGIN 
IF(select DATEDIFF(Year,Birthdate,GetDate())From inserted) <= 16 
BEGIN 
   RAISERROR('Employee must be atleast 16',16,1) 
   ROllBACK TRANSACTION 
  END 
END 

GO 

--TEST EXAMPLE OF POTENTIAL EMPLOYEE THAT WILL BE STOPPED BY TRIGGER BECAUSE HE IS NOT 16 OR OLDER. 

INSERT INTO Employee (FirstName, LastName, Title, JobTitle, BirthDate, HireDate, PhoneNumber, HighestEducation, ReportsTo, AddressID, DepartmentID, BranchID) 
VALUES ('John', 'Smith', 'Mr.', 'Sales Representative', '2020-05-15', '2020-01-01', '0823456789', 'Bachelor of Commerce', 0, 1, 1, 1); 

GO 

--TEST EXAMPLE OF POTENTIAL EMPLOYEE THAT WILL BE NOT STOPPED BY TRIGGER BECAUSE HE IS 16 OR OLDER. 

INSERT INTO Employee (FirstName, LastName, Title, JobTitle, BirthDate, HireDate, PhoneNumber, HighestEducation, ReportsTo, AddressID, DepartmentID, BranchID) 
VALUES ('John', 'Smith', 'Mr.', 'Sales Representative', '2000-05-15', '2020-01-01', '0823456789', 'Bachelor of Commerce', 0, 1, 1, 1); 

GO 

--Cursor: This cursor will display the total number of products sold as well as the sales prices, per product. This will show per month, per year. 
USE ZephyrMotors; 
GO 
 
DECLARE @Year INT, 
@Month VARCHAR(10), 
@ProductName VARCHAR(50), 
@TotalSold INT, 
@SalesTotal MONEY 

BEGIN 
DECLARE crMonthlySales CURSOR FOR 
SELECT YEAR(s.SalesDate) AS [Year], 
CASE 
WHEN MONTH(s.SalesDate) = 1 THEN 'January' 
WHEN MONTH(s.SalesDate) = 2 THEN 'February' 
WHEN MONTH(s.SalesDate) = 3 THEN 'March' 
WHEN MONTH(s.SalesDate) = 4 THEN 'April' 
WHEN MONTH(s.SalesDate) = 5 THEN 'May' 
WHEN MONTH(s.SalesDate) = 6 THEN 'June' 
WHEN MONTH(s.SalesDate) = 7 THEN 'July' 
WHEN MONTH(s.SalesDate) = 8 THEN 'August' 
WHEN MONTH(s.SalesDate) = 9 THEN 'September' 
WHEN MONTH(s.SalesDate) = 10 THEN 'October' 
WHEN MONTH(s.SalesDate) = 11 THEN 'November' 
WHEN MONTH(s.SalesDate) = 12 THEN 'December' 

END AS [Month], --The month's name is extracted from the date 
p.[Name], SUM(ps.Quantity) AS [Total Sold], SUM(ps.Total) AS [Sales Total] 
FROM Sale s 
JOIN ProductSale ps ON s.SalesID = ps.SalesID --The ProductSale table is joined with the Sale table 
JOIN Product p ON ps.ProductID = p.ProductID --The Product table is joined with the ProductSale table 
GROUP BY YEAR(s.SalesDate), MONTH(s.SalesDate), p.[Name] --This shows the totals per product, per month, per year 

OPEN crMonthlySales; --This enables the cursor for use 
FETCH NEXT FROM crMonthlySales INTO @Year, @Month, @ProductName, @TotalSold, @SalesTotal; --This extracts the first row in the cursor 

WHILE @@FETCH_STATUS = 0 --This loops until every record is retrieved from the cursor 
BEGIN 
PRINT '=============================='; 
PRINT 'Year: ' + CONVERT(VARCHAR(20), @Year); 
PRINT 'Month: ' + @Month; 
PRINT 'Product ' + @ProductName; 
PRINT 'Total Sold: ' + CONVERT(VARCHAR(10), @TotalSold); 
PRINT 'Sales Total: R' + CONVERT(VARCHAR(20), @SalesTotal); 
 
FETCH NEXT FROM crMonthlySales INTO @Year, @Month, @ProductName, @TotalSold, @SalesTotal; --This extracts the next record in the cursor 
END 

PRINT '=============================='; 

CLOSE crMonthlySales; --This closes the cursor 
DEALLOCATE crMonthlySales; 

END 

GO 

--LOGIN: A login will be created per department and assign each employee to their relevant login
USE master;  

--Login for sales created
CREATE LOGIN sales_JohnSmith1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_DanielAnderson1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_DanielSmith1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_OliviaPatel1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_EthanGallagher1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_SophiaKim1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_WilliamNguyen1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_CharlotteMitchell1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_LucasSingh1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_AvaWong1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_MasonJohnson1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_MiaRodriguez1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_BenjaminLee1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_IsabellaDavis1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_NoahWright1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_EmmaBrown1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_JamesonChen1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_HarperWilson1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_AlexanderGarcia1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_PenelopeJones1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_ElijahMartinez1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_AbigailTaylor1 WITH PASSWORD = 'sales123';  
CREATE LOGIN sales_DanielHernandez1 WITH PASSWORD = 'sales123';  

USE ZephyrMotors; 
CREATE USER JohnSmith1 FOR LOGIN sales_JohnSmith1;  
CREATE USER DanielAnderson1 FOR LOGIN sales_DanielAnderson1;  
CREATE USER DanielSmith1 FOR LOGIN sales_DanielSmith1;  
CREATE USER OliviaPatel1 FOR LOGIN sales_OliviaPatel1;  
CREATE USER EthanGallagher1 FOR LOGIN sales_EthanGallagher1;  
CREATE USER SophiaKim1 FOR LOGIN sales_SophiaKim1;  
CREATE USER WilliamNguyen1 FOR LOGIN sales_WilliamNguyen1;  
CREATE USER CharlotteMitchell1 FOR LOGIN sales_CharlotteMitchell1;  
CREATE USER LucasSingh1 FOR LOGIN sales_LucasSingh1;  
CREATE USER AvaWong1 FOR LOGIN sales_AvaWong1;  
CREATE USER MasonJohnson1 FOR LOGIN sales_MasonJohnson1;  
CREATE USER MiaRodriguez1 FOR LOGIN sales_MiaRodriguez1;  
CREATE USER BenjaminLee1 FOR LOGIN sales_BenjaminLee1;  
CREATE USER IsabellaDavis1 FOR LOGIN sales_IsabellaDavis1;  
CREATE USER NoahWright1 FOR LOGIN sales_NoahWright1;  
CREATE USER EmmaBrown1 FOR LOGIN sales_EmmaBrown1;  
CREATE USER JamesonChen1 FOR LOGIN sales_JamesonChen1;  
CREATE USER HarperWilson1 FOR LOGIN sales_HarperWilson1;  
CREATE USER AlexanderGarcia1 FOR LOGIN sales_AlexanderGarcia1;  
CREATE USER PenelopeJones1 FOR LOGIN sales_PenelopeJones1;  
CREATE USER ElijahMartinez1 FOR LOGIN sales_ElijahMartinez1;  
CREATE USER AbigailTaylor1 FOR LOGIN sales_AbigailTaylor1;  
CREATE USER DanielHernandez1 FOR LOGIN sales_DanielHernandez1; 

GO 

CREATE ROLE SalesTeam; 

/*Sales team need to be able to select, insert new values such as a new sale, update values based on current situations or 
delete values such as sales that are refunded on the table's sale, ProductSale and Product. */

GRANT SELECT, INSERT, UPDATE, DELETE ON Sale TO SalesTeam; 
GRANT SELECT, INSERT, UPDATE, DELETE ON ProductSale TO SalesTeam; 
GRANT SELECT, INSERT, UPDATE, DELETE ON Product TO SalesTeam; 

ALTER ROLE SalesTeam ADD MEMBER JohnSmith1;  
ALTER ROLE SalesTeam ADD MEMBER DanielAnderson1;  
ALTER ROLE SalesTeam ADD MEMBER DanielSmith1;  
ALTER ROLE SalesTeam ADD MEMBER OliviaPatel1;  
ALTER ROLE SalesTeam ADD MEMBER EthanGallagher1;  
ALTER ROLE SalesTeam ADD MEMBER SophiaKim1;  
ALTER ROLE SalesTeam ADD MEMBER WilliamNguyen1;  
ALTER ROLE SalesTeam ADD MEMBER CharlotteMitchell1;  
ALTER ROLE SalesTeam ADD MEMBER LucasSingh1;  
ALTER ROLE SalesTeam ADD MEMBER AvaWong1;  
ALTER ROLE SalesTeam ADD MEMBER MasonJohnson1;  
ALTER ROLE SalesTeam ADD MEMBER MiaRodriguez1;  
ALTER ROLE SalesTeam ADD MEMBER BenjaminLee1;  
ALTER ROLE SalesTeam ADD MEMBER IsabellaDavis1;  
ALTER ROLE SalesTeam ADD MEMBER NoahWright1;  
ALTER ROLE SalesTeam ADD MEMBER EmmaBrown1;  
ALTER ROLE SalesTeam ADD MEMBER JamesonChen1;  
ALTER ROLE SalesTeam ADD MEMBER HarperWilson1;  
ALTER ROLE SalesTeam ADD MEMBER AlexanderGarcia1;  
ALTER ROLE SalesTeam ADD MEMBER PenelopeJones1;  
ALTER ROLE SalesTeam ADD MEMBER ElijahMartinez1;  
ALTER ROLE SalesTeam ADD MEMBER AbigailTaylor1;  
ALTER ROLE SalesTeam ADD MEMBER DanielHernandez1;

GO

--Login for Marketing
USE master;  

CREATE LOGIN Market_JaneDoe WITH PASSWORD = 'janedoe123';  

CREATE LOGIN Market_JessicaThomas WITH PASSWORD = 'jessica1234';  
  
USE ZephyrMotors;  

CREATE USER JaneDoe1 FOR LOGIN Market_JaneDoe;  

CREATE USER JessicaThomas1 FOR LOGIN Market_JessicaThomas;  

CREATE ROLE MarketingTeam;  

--Marketing Team need to be able to see any data related to customers on the customer table. 

GRANT SELECT ON Customer TO MarketingTeam;  

ALTER ROLE MarketingTeam ADD MEMBER JaneDoe1;  

ALTER ROLE MarketingTeam ADD MEMBER JessicaThomas1; 

GO 

--Login for HR
USE master;  
  
CREATE LOGIN HR_MaryJohnson WITH PASSWORD = 'password1988';  

USE ZephyrMotors;  

CREATE USER MaryJohnson1 FOR LOGIN HR_MaryJohnson;  

CREATE ROLE HRTeam;  

--HRTeam will need to be able to select, insert, update or even delete any data on the employees table such as employees that left. 

GRANT SELECT, INSERT, UPDATE, DELETE ON Employee TO HRTeam;  

ALTER ROLE HRTeam ADD MEMBER MaryJohnson1; 

GO

--Login for IT
USE ZephyrMotors;

CREATE LOGIN IT_RobertWilliams WITH PASSWORD = 'verysecureadminpassword'; 

CREATE USER RobertWilliams1 FOR LOGIN IT_RobertWilliams; 

CREATE ROLE ITDepartment; 

GRANT SELECT, INSERT, UPDATE, DELETE ON SupplierAddress TO ITDepartment; 
GRANT SELECT, INSERT, UPDATE, DELETE ON CustomerAddress TO ITDepartment; 
GRANT SELECT, INSERT, UPDATE, DELETE ON EmployeeAddress TO ITDepartment; 
GRANT SELECT, INSERT, UPDATE, DELETE ON Supplier TO ITDepartment; 
GRANT SELECT, INSERT, UPDATE, DELETE ON Category TO ITDepartment; 
GRANT SELECT, INSERT, UPDATE, DELETE ON Product TO ITDepartment; 
GRANT SELECT, INSERT, UPDATE, DELETE ON Department TO ITDepartment; 
GRANT SELECT, INSERT, UPDATE, DELETE ON Branch TO ITDepartment; 
GRANT SELECT, INSERT, UPDATE, DELETE ON Employee TO ITDepartment; 
GRANT SELECT, INSERT, UPDATE, DELETE ON Customer TO ITDepartment; 
GRANT SELECT, INSERT, UPDATE, DELETE ON Sale TO ITDepartment; 
GRANT SELECT, INSERT, UPDATE, DELETE ON ProductSale TO ITDepartment; 

ALTER ROLE ITDepartment ADD MEMBER RobertWilliams1

GO
--Login for Research Development
USE master;   

CREATE LOGIN RD_Login WITH PASSWORD = 'StrongPassword123!';  

USE ZephyrMotors;   

CREATE USER ElizabethBrown1 FOR LOGIN RD_Login;  

CREATE ROLE RDTeam;  

-- RDTeam needs to be able to see all the data related to the sale , ProductSale, product, supplier and the category tables that might be useful to research and development. 

GRANT SELECT ON [Sale] TO RDTeam;  
GRANT SELECT ON [ProductSale] TO RDTeam;  
GRANT SELECT ON [Product] TO RDTeam;  
GRANT SELECT ON [Supplier] TO RDTeam;  
GRANT SELECT ON [Category] TO RDTeam;  

ALTER ROLE RDTeam ADD MEMBER ElizabethBrown1; 

GO 

--Login for Customer Service
USE master;   

CREATE LOGIN CustomerService_Login WITH PASSWORD = 'customer_service123';  

USE ZephyrMotors;   

CREATE USER MichaelDavis1 FOR LOGIN CustomerService_Login;  

CREATE ROLE CustomerServiceTeam;  

-- The Customer Service Team need to be able to access any data related to products or customer's orders(sales). 

GRANT SELECT ON Customer TO CustomerServiceTeam;  
GRANT SELECT ON Sale TO CustomerServiceTeam;  
GRANT SELECT ON ProductSale TO CustomerServiceTeam;  
GRANT SELECT ON Product TO CustomerServiceTeam;  
GRANT SELECT ON Supplier TO CustomerServiceTeam;  
  
ALTER ROLE CustomerServiceTeam ADD MEMBER MichaelDavis1;  

GO

--Login for Operations

USE master;   

CREATE LOGIN Operations_Login WITH PASSWORD = 'amanda_wilson123';  

USE ZephyrMotors;   

CREATE USER AmandaWilson1 FOR LOGIN Operations_Login; 

/*operations team need to be able to add new suppliers, their products and their address. They also need to be able to select such data and make any 
edits such as a supplier moving */
  
CREATE ROLE OperationsTeam;  

GRANT SELECT, UPDATE, INSERT, DELETE ON Supplier TO OperationsTeam;  
GRANT SELECT, UPDATE, INSERT, DELETE ON SupplierAddress TO OperationsTeam;  
GRANT SELECT, UPDATE, INSERT, DELETE ON Product TO OperationsTeam;  

ALTER ROLE OperationsTeam ADD MEMBER AmandaWilson1;  

GO

--Login for Purchasing
USE master;   

CREATE LOGIN Purchasing_Login WITH PASSWORD = 'christopher_moore123';  

USE ZephyrMotors;   

CREATE USER ChristopherMoore1 FOR LOGIN Purchasing_Login;  

CREATE ROLE PurchasingTeam;   

GRANT SELECT, UPDATE, INSERT ON Sale TO PurchasingTeam;   
GRANT SELECT, UPDATE, INSERT ON Product TO PurchasingTeam;   
GRANT SELECT, UPDATE, INSERT ON Supplier TO PurchasingTeam;   
GRANT SELECT, UPDATE, INSERT ON SupplierAddress TO PurchasingTeam;   
GRANT SELECT, UPDATE, INSERT ON ProductSale TO PurchasingTeam;  
CREATE ROLE PurchasingTeam; 

-- PurchasingTeam need to be able to select, update or insert values into the sale,product,supplier,supplieraddress and productsale as to make sure that stock is adequate. 
  
ALTER ROLE PurchasingTeam ADD MEMBER ChristopherMoore1;  

GO

--Login for Quality Control
USE master;   
  
CREATE LOGIN QualityControl_Login WITH PASSWORD = 'emily_taylor123';  
  
USE ZephyrMotors;   

CREATE USER EmilyTaylor1 FOR LOGIN QualityControl_Login;  

CREATE ROLE QualityControlTeam; 

-- Quality Control Team need to see all the data stored on the tables product, category, supplier to make sure that standards are being maintained. 

GRANT SELECT ON Product TO QualityControlTeam;  
GRANT SELECT ON Category TO QualityControlTeam;  
GRANT SELECT ON Supplier TO QualityControlTeam;  

ALTER ROLE QualityControlTeam ADD MEMBER EmilyTaylor1; 

GO

--Login for Finance
USE master;  

CREATE LOGIN Finance_Login WITH PASSWORD = 'finance123';  

USE ZephyrMotors;   

CREATE USER DavidJones1 FOR LOGIN Finance_Login;  

CREATE ROLE FinanceTeam;  

--Finance team needs to be able to see all values stored in the product, category and supplier table to make more informed decisions on the company's finances. 

GRANT SELECT ON Product TO FinanceTeam;  
GRANT SELECT ON Category TO FinanceTeam;  
GRANT SELECT ON Supplier TO FinanceTeam;  

ALTER ROLE FinanceTeam ADD MEMBER DavidJones1;  

GO

--Backup
BACKUP DATABASE ZephyrMotors 
TO DISK = 'C:\Backup\ZephyrMotors.bak' 
WITH INIT, COMPRESSION; 