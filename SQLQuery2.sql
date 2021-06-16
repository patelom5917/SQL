--Inner Join On Both Table

SELECT * 
FROM EmployeeDemographics 
Inner Join EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--Full Outer Join
SELECT * 
From EmployeeDemographics
FUll Outer Join EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--left outer join
SELECT * 
From EmployeeDemographics 
Left Outer Join EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--Right Outer Join
SELECT * 
From EmployeeDemographics 
Right Outer Join EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--left outer join with specific columns

SELECT EmployeeSalary.EmployeeID, FirstName, LastName,Salary 
From EmployeeDemographics 
Left Outer Join EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

/*Use case-1 Company is pressuring Michael to meet his quarterly Quota and michael is almost there and he needs like a thousand more dollars 
and he comes up with the genius idea to deduct pay for the highest pay employee at his branch besides himself so how does he go about doing this
identifying the person that makes the moost money*/

SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, Salary
From EmployeeDemographics 
Inner Join EmployeeSalary 
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Where FirstName <> 'Michael'
Order by Salary Desc

-- Use case-2 accountant makes mistake to calculate Average salary of Salesman Find Avg salary of saleman

Select JobTitle , Avg(Salary) As 'Average salary'
From EmployeeDemographics
Inner Join EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Where JobTitle = 'Salesman'
Group by JobTitle


--Union

Create Table WareHouseEmployeeDemographics
(EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50))


Insert into WareHouseEmployeeDemographics Values
(1013,'Darryl','Philbin',Null,'Male'),
(1050,'Roy','Anderson',31,'Male'),
(1051,'Hidetoshi','Hasagawa',40,'Male'),
(1052,'Val','Johnson',31,'Female')

Select *
From EmployeeDemographics
Union
Select *
From WareHouseEmployeeDemographics

Select *
From EmployeeDemographics
Union All
Select *
From WareHouseEmployeeDemographics


--CASE

SELECT FirstName, LastName ,Age,
CASE 
	When Age = 38 Then 'Stanley'
	When Age > 30 Then 'Old'
	Else 'Baby'
End As 'Age group'
From EmployeeDemographics
Where Age is Not Null
Order by Age

-- SalaryRise based on their JobTitle

Select Firstname, Lastname, JobTitle, Salary,
CASE
	When JobTitle = 'Salesman' Then Salary + (Salary * 0.10)
	When JObTitle = 'Accountant' Then Salary + (Salary * 0.5)
	When JobTitle = 'HR' Then Salary + (Salary * 0.2)
	Else Salary + (Salary * 0.01)
End As 'SalaryAfterRise'
From EmployeeDemographics 
Inner Join EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--Having Clause

Select JobTitle, Count(JobTitle)
From EmployeeDemographics 
Inner Join EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Group By JobTitle

--If We want to add condition on group by function then we Must use Having Clause instead of Where

Select JobTitle, Count(JobTitle)
From EmployeeDemographics 
Inner Join EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Group By JobTitle
Having Count(JobTitle)>1

--Update and Delete Query

Select * From EmployeeDemographics

Update EmployeeDemographics
Set EmployeeID = 1012 
Where FirstName = 'Holly' And LastName = 'Flax'

Update EmployeeDemographics
Set Age = 35, Gender= 'Female'
Where EmployeeID = 1012

Delete From EmployeeDemographics
Where EmployeeID = 1012

--Aliasing

Select FirstName + ' ' + Lastname As 'Full Name'
From EmployeeDemographics

Select Demo.EmployeeID, Demo.FirstName, Demo.LastName, salary.Salary,warehouse.Age
From EmployeeDemographics as Demo
Left Outer Join EmployeeSalary salary
On Demo.EmployeeID = salary.EmployeeID
Left Outer Join WareHouseEmployeeDemographics warehouse
on Demo.EmployeeID = warehouse.EmployeeID


--Partition By

Select EmployeeDemographics.EmployeeID,FirstName,LastName, Age,Gender,
Count(Gender) Over (Partition By Gender) As TotalGender
From EmployeeDemographics 
Inner Join EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID