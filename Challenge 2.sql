-- 1. Display the Department id, name and id and the name of its manager.
SELECT d.dnum AS "Department ID" ,d.dname AS "Department Name",e.ssn AS "Manager ID" ,CONCAT(e.fname,' ',e.lname) AS "Manager Name"
FROM department d
JOIN employee e 
ON d.mgrssn = e.ssn;
-----------------------------------------------------------------------------

-- 2. Display the name of the departments and the name of the projects under its control.
SELECT d.dname AS "Department Name", p.pname AS "Project Name"
FROM department d
JOIN project p
ON d.dnum = p.dnum;
-----------------------------------------------------------------------------

-- 3. Display the full data about all the dependence associated with the name of the employee they depend on him/her.
SELECT d.*, CONCAT(e.fname,' ',e.lname) AS "Employee Name"
FROM dependent d, employee e
WHERE d.essn = e.ssn;
-----------------------------------------------------------------------------

-- 4. Display (Using Union Function)
-- a. The name and the gender of the dependence that's gender is Female and depending on Female Employee.
-- b. And the male dependence that depends on Male Employee.
SELECT d.dependent_name, d.gender
FROM employee e
JOIN dependent d 
ON e.ssn = d.essn
WHERE e.gender = 'F' AND d.gender = 'F'
UNION
SELECT d.dependent_name, d.gender
FROM employee e
JOIN dependent d
ON e.ssn = d.essn
WHERE e.gender = 'M' AND d.gender = 'M';
-----------------------------------------------------------------------------

/*5. Display the full names and gender of all the employees, union the names and 
genders of the dependents.*/
SELECT CONCAT(fname,' ',lname) AS "Name", gender
FROM employee
UNION
SELECT Dependent_name, gender
FROM dependent;
-----------------------------------------------------------------------------

-- 6. Display the Id, name and location of the projects in Cairo or Alex city.
SELECT pnumber, pname, plocation
FROM project
WHERE city IN ('Cairo', 'Alex');
-----------------------------------------------------------------------------

-- 7. Display the Projects full data of the projects with a name starts with "a" letter.
SELECT *
FROM project
WHERE pname LIKE "a%";
-----------------------------------------------------------------------------

-- 8. display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
SELECT *
FROM employee
WHERE dno = 30 AND salary BETWEEN 1000 AND 2000;
-----------------------------------------------------------------------------

/* 9. 
Retrieve the names of all employees
in department 20
who work more than or equal to 10 hours per week
on "Al Rawdah" project.*/

SELECT CONCAT(e.fname,' ',e.lname) AS "Employee Name"
FROM employee e
JOIN works_on w ON e.ssn = w.essn
JOIN project p ON w.pno = p.pnumber
WHERE e.dno = 20 AND w.weekly_hours >= 10 AND p.pname = "Al Rawdah";
-----------------------------------------------------------------------------

--10. Find the names of the employees who directly supervised with Amr Omran.
SELECT CONCAT(e.fname,' ',e.lname) AS Name
FROM employee e
JOIN employee m ON e.superssn = m.ssn
WHERE m.fname = 'Amr' AND m.lname = 'Omran';
-----------------------------------------------------------------------------

/*11. For each project, list the project name and the total hours per week (for all
employees) spent on that project.*/
SELECT p.pname, SUM(w.weekly_hours) AS "Total Hours"
FROM project p
JOIN works_on w ON p.pnumber = w.pno
GROUP BY  p.pname;
-----------------------------------------------------------------------------

/*12. Retrieve the names of all employees and the names of the projects they are 
working on, sorted by the project name.*/
SELECT CONCAT(e.fname,' ',e.lname) AS Name 
FROM employee e
JOIN works_on w ON e.ssn = w.essn
JOIN project p ON w.pno = p.pnumber
ORDER BY p.pname;
-----------------------------------------------------------------------------

/*13. Display all the data of the department which has the smallest employee ID over 
all employees' ID.*/
 SELECT d.*
 FROM department d
 JOIN employee e ON e.dno = d.dnum
 WHERE e.ssn = (SELECT MIN(ssn) FROM employee);
-----------------------------------------------------------------------------

/*14. For each department, retrieve the department name and the maximum, minimum 
and average salary of its employees.*/
SELECT d.dname, MAX(e.salary) AS MaxSalary, MIN(e.salary) AS MinSalary, AVG(e.salary) AS AvgSalary
FROM department d
JOIN employee e ON d.dnum = e.dno
GROUP BY d.dname;
-----------------------------------------------------------------------------

--15. List the last name of all super who have no dependents.
SELECT lname
FROM employee
WHERE ssn IN (SELECT superssn FROM employee)
AND ssn NOT IN (SELECT essn FROM dependent);
-----------------------------------------------------------------------------

/* 16. 
For each department
-- if its average salary is less than the average salary of all employees
-- display its number, name and number of its employees.
*/

SELECT d.dname, AVG(e.salary) AS AvgSalary, COUNT(e.ssn) EmployeeNO
FROM employee e
JOIN department d ON d.dnum = e.dno
GROUP BY d.dname
HAVING AVG(e.salary) < (SELECT AVG(salary) FROM employee);
-----------------------------------------------------------------------------

/*17. Retrieve a list of employees and the projects they are working on ordered by 
department and within each department, ordered alphabetically by last name, first 
name.*/
SELECT e.* ,p.*
FROM employee e
JOIN works_on w ON e.ssn = w.essn
JOIN project p ON w.pno = p.pnumber;
ORDER BY e.dno, e.lname, e.fname;
-----------------------------------------------------------------------------

/*18. For each project located in Cairo City, find the project number, the controlling 
department name, the department manager’s last name, address, and birthdate.*/

SELECT p.pnumber, d.dname, e.lname, e.address, e.bdate
FROM project p
JOIN department d ON p.dnum = d.dnum
JOIN employee e ON e.ssn = d.mgrssn
WHERE p.city = "Cairo"
ORDER BY p.pnumber;
-----------------------------------------------------------------------------
