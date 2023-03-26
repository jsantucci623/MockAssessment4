/* Mock Assessment 4
Jeff Santucci
03/22/23


SQL STATEMENTS:
Create a database called CompanyDb. (Make sure to use it as well)
Construct a table called Department. Department has the following columns:
Id- int PK auto-increment
Name - nvarchar 25 NOT NULL
Hiring - bit
Location - nvarchar 50
Add the two departments from above to the table.
Construct a table named Employee. Employee has the following columns.
SSN - nchar 9 PK
DOB - DATE
Phone - nchar 10
FirstName - nvarchar 30 NOT NULL
LastName - nvarchar 30 NOT NULL
DepartmentId- This is a foreign key reference to Departments. Choose the appropriate data type. (Note this is a many-to-one relationship: many employees to one department.)
Add the 4 employees from above to the table.
Update the youngest employee to have a LastName of “Spiderman”.
Select all employees with the LastName that starts with “J”.
Remove the oldest employee.
Select all employees with a 313 area code.
Select all employees that have a DOB before 9/9/1999.
Update the employees with DOB after 2000 to have no phone number.
Select all employees that do not have a phone number.
Use one statement to list all employees along with the name and location of the department the employee belongs to.
Delete both tables and all their contents from the database.

*/


-- 1. Create a database called CompanyDb. (Make sure to use it as well)
CREATE DATABASE CompanyDb;
USE CompanyDb;

-- 2. Construct a table called Department. Department has the following columns:
/* Id- int PK auto-increment
Name - nvarchar 25 NOT NULL
Hiring - bit
Location - nvarchar 50
*/
CREATE TABLE Department 
(
id int NOT NULL IDENTITY(1,1) PRIMARY KEY,  -- start at 1 and go by 1
Name nvarchar(25) NOT NULL,
Hiring bit,
Location nvarchar(50)
);

-- 3. Add the two departments from above to the table.
INSERT INTO Department (Name, Hiring, Location) VALUES ('Technology', 1, '1570 Woodward Ave.');
INSERT INTO Department (Name, Hiring, Location) VALUES ('Shipping & Receiving', 0, 'Southfield');

-- 4. Construct a table named Employee. Employee has the following columns.
/* SSN - nchar 9 PK
   DOB - DATE
   Phone - nchar 10
   FirstName - nvarchar 30 NOT NULL
   LastName - nvarchar 30 NOT NULL
   DepartmentId- This is a foreign key reference to Departments. Choose the appropriate data type. (Note this is a many-to-one relationship: many emplo
*/
CREATE TABLE Employee 
(
SSN nchar(9) NOT NULL PRIMARY KEY,  
DOB datetime2,
Phone nchar(10),
FirstName nvarchar(30) NOT NULL,
LastName nvarchar(30) NOT NULL,
DepartmentId int FOREIGN KEY REFERENCES Department(id)
);

-- 5. Add the 4 employees from above to the table.
INSERT INTO Employee(SSN, DOB, Phone, FirstName, LastName, DepartmentId) VALUES ('123456789', '1/5/1975', '313555505', 'Charles', 'Charleston', 2);
INSERT INTO Employee(SSN, DOB, Phone, FirstName, LastName, DepartmentId) VALUES ('987654321', '5/2/1990', '2489995555', 'Jimmy', 'Scrambles', 1);
INSERT INTO Employee(SSN, DOB, Phone, FirstName, LastName, DepartmentId) VALUES ('456789123', '8/6/2001', '7895555525', 'Vince', 'Jabowski', 1);
INSERT INTO Employee(SSN, DOB, Phone, FirstName, LastName, DepartmentId) VALUES ('654854632', '4/6/1988', '3139721400', 'John', 'Johnston', 2);

-- 6. Update the youngest employee to have a LastName of “Spiderman”.

UPDATE Employee 
SET employee.LastName = 'Spiderman'
WHERE Employee.DOB = (SELECT MAX(DOB) AS EarliestDate FROM Employee);

SELECT * FROM Employee;

-- 7. Select all employees with the LastName that starts with “J”.

SELECT * FROM Employee 
WHERE Employee.LastName LIKE 'J%';

-- 8. Remove the oldest employee.

SELECT * FROM Employee; 
DELETE Employee
WHERE Employee.DOB = (SELECT MIN(DOB) AS EarliestDate FROM Employee);
SELECT * FROM Employee; 

-- 9. Select all employees with a 313 area code.

SELECT * FROM EMPLOYEE 
WHERE Employee.Phone LIKE '313%';

-- 10. Select all employees that have a DOB before 9/9/1999.

SELECT * FROM EMPLOYEE 
WHERE Employee.DOB < '09/09/1999';

-- 11. Update the employees with DOB after 2000 to have no phone number.

UPDATE Employee 
SET Employee.Phone = ''
WHERE Employee.DOB >= '01/01/2000'; 

-- 12. Select all employees that do not have a phone number.

SELECT * FROM EMPLOYEE 
WHERE Employee.Phone = '';

-- 13. Use one statement to list all employees along with the name and location of the department the employee belongs to.
SELECT * FROM EMPLOYEE 
INNER JOIN Department 
ON Employee.DepartmentId = Department.id;

-- 14. Delete both tables and all their contents from the database.
DELETE Employee;
DELETE Department;
DROP TABLE Employee;
DROP TABLE Department;



