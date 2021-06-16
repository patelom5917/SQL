/*
CTE
*/

WITH CTE_Employee as
(SELECT FirstName, LastName, Gender, Salary,
Count(Gender) Over (partition by Gender) As TotalGender,
AVG(Salary) Over (Partition by Gender) As AvgGenderSalary
From EmployeeDemographics
Inner Join EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Where EmployeeSalary.Salary > '45000'
)

--Select * From CTE_Employee

Select FirstName, TotalGender, AvgGenderSalary  From CTE_Employee

/*
Temp_Table
*/

CREATE TABLE #Temp_Employee
(EmployeeID int,
JobTitle varchar(50),
Salary int
)

INSERT INTO #Temp_Employee VALUES
(10010,'HR',45000)

INSERT INTO #Temp_Employee 
SELECT * 
FROM EmployeeSalary

Select * From #Temp_Employee


Drop Table IF Exists #Temp_Employee2
CREATE TABLE #Temp_Employee2(
JobTitle varchar(50),
EmployeePerJob int,
AvgAge int,
AvgSalary int)

INSERT INTO #Temp_Employee2
SELECT JobTitle, Count(JobTitle),Avg(Age),Avg(Salary)
From EmployeeDemographics
Inner Join EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Group By JobTitle

Select * From #Temp_Employee2


/*
String Functions TRIM, LTRIM, RTRIM, REPLACE, UPPER, LOWER, SubString
*/

CREATE TABLE EmployeeErrors
(EmployeeID varchar(50),
FirstName varchar(50),
LastName varchar(50))

Insert Into EmployeeErrors Values
('1001 ','Jimbo','Halbert'),
(' 1002','Pamela', 'Beasely'),
('1005','TOby', 'Flenderson - Fires')

SELECT *
From EmployeeErrors

--Using TRIM, LTRIM, RTRIM

Select EmployeeID , TRIM(EmployeeID) AS TRIMID 
From EmployeeErrors

Select EmployeeID , LTRIM(EmployeeID) AS TRIMID 
From EmployeeErrors

Select EmployeeID , RTRIM(EmployeeID) AS TRIMID 
From EmployeeErrors

--Using Replace

Select LastName , REPLACE(LastName, '- Fires','') as LastNameFixed
From EmployeeErrors

--Using SubString

Select  FirstName, SUBSTRING(FirstName,2,3)
From EmployeeDemographics

Select demo.FirstName,SUBSTRING(demo.FirstName,1,3) , er.FirstName, SUBSTRING(er.FirstName,1,3)
From EmployeeDemographics as demo
Inner Join EmployeeErrors as er
On SUBSTRING(demo.FirstName,1,3) = SUBSTRING(er.FirstName,1,3)

--Using UPPER And Lower

Select FirstName,UPPER(FirstName) as UPPER_FirstName, LOWER(FirstName) as LOWER_FirstName
From EmployeeDemographics


/*
PROCEDURE
*/

Create Procedure Test
AS
Select *
From EmployeeDemographics

EXEC Test

Create Procedure Temp_Employee
@JobTitle nvarchar(100)
As
CREATE TABLE #Temp_Employee3(
JobTitle varchar(50),
EmployeePerJob int,
AvgAge int,
AvgSalary int)

INSERT INTO #Temp_Employee3
SELECT JobTitle, Count(JobTitle),Avg(Age),Avg(Salary)
From EmployeeDemographics
Inner Join EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Where JobTitle = @JobTitle
Group By JobTitle

Select * From #Temp_Employee3

EXEC Temp_Employee @JobTitle = 'Salesman'


/*
SubQueries (in the select, From, Where Statement) 
*/

--SubQuery in Select

Select EmployeeID, Salary, (Select Avg(Salary) From EmployeeSalary) As AvgSalary
From EmployeeSalary

--DO with Partition By
Select EmployeeID, Salary, Avg(Salary) Over() As AvgSalary
From EmployeeSalary

--SubQuery in From

Select a.EmployeeID, a.AvgSalary
From(Select EmployeeID, Salary, Avg(Salary) Over() As AvgSalary
	From EmployeeSalary) a

--SunQuery in Where

Select EmployeeID, Salary, JobTitle
From EmployeeSalary
Where EmployeeID In (
	Select EmployeeID
		From EmployeeDemographics)