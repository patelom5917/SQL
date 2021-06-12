--CREATE TABLE 1 Query

CREATE TABLE EmployeeDemographics
(EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)

--CREATE TABLE 2 Query

CREATE TABLE EmployeeSalary
(EmployeeID int,
JobTitle varchar(50),
Salary int)

--Insert value in table 1 Query

INSERT INTO EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

--Insert value in table 2 Query

INSERT INTO EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)


/*
select statement
 Top, Count, As, Distinct, Min, Max, Avg 
*/

-- Top 5 row with all columns from EmployeeDemographics Table

SELECT Top 5 * 
FROM EmployeeDemographics

-- Top 5 row with specific columns from EmployeeDemographics Table 

SELECT Top 5 FirstName, LastName 
	From EmployeeDemographics

-- Count total number of row

SELECT COUNT(*) 
From EmployeeDemographics

-- Count total number of row give name Total Rows

SELECT COUNT(*) AS 'TotalRows' 
From EmployeeDemographics

-- DISTINCT Value of jobtitle From EmployeeSalary

SELECT DISTINCT(JobTitle) 
From EmployeeSalary

-- MIN salary From EmployeeSalary

SELECT MIN(Salary) 
FROM EmployeeSalary

-- MAX salary From EmployeeSalary

SELECT MAX(Salary) 
FROM EmployeeSalary

--AVG salary From EmployeeSalary

SELECT AVG(Salary) AS 'AverageSalary'
FROM EmployeeSalary

/*
WHERE Statement use to get some specific results by applying some condition  
WHERE Statement 
=, <, >, <>, LIKE, IN, AND,OR, NULL, NOT NULL
*/

-- Get data whoes first name is Jim
SELECT * 
FROM EmployeeDemographics 
WHERE FirstName = 'Jim'

--Get Data whoes Age is grater than 30 And FirstName start with 'M'
SELECT * 
FROM EmployeeDemographics 
WHERE Age >30 And FirstName Like 'M%'

--Get Data whoes Age is not equal to 30
SELECT * 
FROM EmployeeDemographics 
WHERE Age <>30

--Get Data whoes salary is less than 45000 
SELECT * 
FROM EmployeeSalary 
WHERE Salary <45000

-- Get data whoes name has 'e' letter and age in 30,31,32
SELECT * 
FROM EmployeeDemographics
WHERE FirstName LIKE '%e%' AND Age IN (30,31,32)

--Get data whoes FirtName end with 'm' or LatName Start with 'H' And Age is NOT NULL value
SELECT * 
FROM EmployeeDemographics
WHERE FirstName LIKE '%m' OR LastName Like 'H%' AND Age is NOT NULL


/*
Group by and order by
*/

-- count total number of female and male
SELECT Gender, Count(Gender) As 'Total'
From EmployeeDemographics Group by Gender

--Count how many number of male and female belong to which age group
SELECT  Gender, Age, Count(Gender) 
From EmployeeDemographics Group by Gender,Age

--now we order our result in ascending order
SELECT * 
From EmployeeDemographics Where Age >30 Order by FirstName ASC

-- we can also use multiple columns to order our result
SELECT *
From EmployeeDemographics Order by Age ASC, FirstName DESC

--Use Where , Group by , Order by in single Query to get total number of person belongs to different age group and age group <40 and order this result into descending order 
SELECT Age,Count(Age) As 'Total'
From EmployeeDemographics Where Age <40 Group by Age Order by 'Total'  DESC

--we also use column number instead of column name
SELECT * 
From EmployeeDemographics Order by 4,5 ASC