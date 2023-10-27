-----------------------------------------------------------------------------
-----------------------Data Manipulating Language----------------------------
-----------------------------------------------------------------------------

/*1. Insert your personal data to the employee table as a new employee in department 
number 30, SSN = 102672, Superssn = 112233.*/

INSERT INTO employee
(fname, lname, ssn, address, bdate, gender, salary, superssn, dno) 
VALUES 
('ashraf','elshazly',102672,'mansoura','2000-8-10','M',21000,112233,30);
-----------------------------------------------------------------------------

/*2. Insert another employee with personal data your friend as new employee in 
department number 30, SSN = 102660, but don’t enter any value for salary or 
manager number to him.*/

INSERT INTO employee
(fname, lname, ssn, address, bdate, gender, dno) 
VALUES 
('mohamed','adel',102660,'mansoura','2000-3-7','M',30);
-----------------------------------------------------------------------------

/*3. In the department table insert new department called "DEPT IT" , with dnum = 100,
employee with SSN = 112233 as a manager for this department. The start date for this 
manager is '1-11-2006'*/

INSERT INTO department
(dnum, dname, mgrssn, `MGRStart Date`) 
VALUES 
(100,'DEPT IT',112233, '2006-11-1');
-----------------------------------------------------------------------------
/*4. Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574) moved to 
be the manager of the new department (id = 100), and they give you(use your SSN 
from question1) her position (Dept. 20 manager) */
--a. First try to update her record in the department table
UPDATE department
SET mgrssn = 968574
WHERE dnum = 100;
--b. Update the department record so you could be department 20 manager.
UPDATE department
SET mgrssn = 102672
WHERE dnum = 20;
--c.Update your friend data(entered in question2) to be in your team (supervised by you)
UPDATE employee
SET superssn = 102672, Dno=20
WHERE ssn = 102660;

-----------------------------------------------------------------------------
/*5. Unfortunately the company ended the contract with Mr. Kamel Mohamed 
(SSN=223344) so try to delete his data from your database in case you know that you 
will be temporarily in his position.
Hint: (Check if Mr. Kamel has dependents, works as a department manager, 
supervises any employees or works in any projects and handle these cases).*/

SELECT *
FROM dependent
WHERE essn = 223344;

DELETE FROM dependent
WHERE essn = 223344;

SELECT *
FROM department
WHERE mgrssn = 223344;

SELECT *
FROM employee
WHERE superssn = 223344;

UPDATE employee
SET superssn = NULL
WHERE superssn = 223344;

DELETE FROM works_on
WHERE essn = 223344;

DELETE FROM employee
WHERE ssn = 223344;
-----------------------------------------------------------------------------
/*6. And your salary has been upgraded by 20 present of its last value.*/

UPDATE employee
SET salary = salary * 1.2
WHERE ssn = 102672;

-----------------------------------------------------------------------------
-----------------------Write the following Queries---------------------------
-----------------------------------------------------------------------------
/*1. Display all the employees Data.*/

SELECT * FROM employee;
-----------------------------------------------------------------------------
/*2. Display the employee First name, last name, Salary and Department number.*/

SELECT fname,lname,salary,dno FROM employee;
-----------------------------------------------------------------------------
/*3. Display all the projects names, locations and the department which is responsible 
about it.*/

SELECT pname,plocation,dnum
FROM project;
-----------------------------------------------------------------------------
/*4. If you know that the company policy is to pay an annual commission for each 
employee with specific percent equals 10% of his/her annual salary .Display each 
employee full name and his annual commission in an ANNUAL COMM column 
(alias).*/

SELECT CONCAT(fname, ' ', lname) AS `full name`, salary * 0.1 AS `ANNUAL COMM`
FROM employee;
-----------------------------------------------------------------------------
/*5. Display the employees Id, name who earns more than 1000 LE monthly.*/

SELECT CONCAT(fname, ' ', lname) AS `full name` , ssn 
FROM employee 
WHERE salary>1000;
-----------------------------------------------------------------------------
/*6. Display the employees Id, name who earns more than 10000 LE annually. */

SELECT CONCAT(fname, ' ', lname) AS `full name` , ssn 
FROM employee 
WHERE salary*12 > 10000;
-----------------------------------------------------------------------------
/*7. Display the names and salaries of the female employees */

SELECT CONCAT(fname, ' ', lname) AS `full name`, salary
FROM employee
WHERE gender = 'F';
-----------------------------------------------------------------------------
/*8. Display each department id, name which managed by a manager with id equals 
968574.*/

SELECT dnum, dname
FROM department
WHERE mgrssn = 968574;
-----------------------------------------------------------------------------
/*9. Dispaly the ids, names and locations of the pojects which controled with 
department 10.*/

SELECT pnumber, pname, plocation
FROM project
WHERE dnum = 10;

-----------------------------------------------------------------------------
---------------------- Ashraf Mohsen Hassan Elshazly ------------------------
-------------------------------- Lab2 ---------------------------------------
-----------------------------------------------------------------------------






















