--1 - Display Employees Which First Name contains Character 'm'
SELECT * FROM employees WHERE first_name LIKE '%m%';
-----------------------------------------------------------------------------

--2 - Display Employees Data Which Earn Salary greater than 60000
SELECT * FROM employees WHERE salary > 60000;

--3 - Display Employee Full Name With Department Name Which is Working On It
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.dept_name
FROM employees e
 JOIN departments AS d
ON e.dept_no = d.dept_no;
-----------------------------------------------------------------------------

--4 – Display Student Data Which has Grade Greater than 70 on any Course
SELECT * 
FROM students s
JOIN students_course sc
ON s.student_no = sc.student_no
WHERE sc.grade > 70;
-----------------------------------------------------------------------------

--5 – Display 2 maximum Different Salary For Employees
SELECT DISTINCT salary 
FROM employees 
ORDER BY salary DESC
LIMIT 2;
-----------------------------------------------------------------------------

--6 - Display Departments & Employees Data which have Employees or not
SELECT d.*, e.*
FROM departments d
LEFT JOIN employees e
ON d.dept_no = e.dept_no;
-----------------------------------------------------------------------------

--7 – Display Employee Who earn salary greater than 100000 and work in Department “Sales”
SELECT * 
FROM employees 
WHERE salary > 100000 
AND dept_no = (SELECT dept_no FROM departments WHERE dept_name = 'Sales');
-----------------------------------------------------------------------------

--8 – Display Student Name and Course Name and Grade for him
SELECT students.student_name, courses.course_name, students_course.grade
FROM students
JOIN students_course ON students.student_no = students_course.student_no
JOIN courses ON students_course.course_no = courses.course_no;
-----------------------------------------------------------------------------

--9 – Display Employees Data which Has salary and has no bonus
SELECT *
FROM employees
WHERE salary IS NOT NULL AND bonus IS NULL;
-----------------------------------------------------------------------------

--10 – Display Departments which contains employees with No Title 
SELECT d.*
FROM departments d
JOIN employees e ON d.dept_no = e.dept_no
WHERE e.title IS NULL;
-----------------------------------------------------------------------------

--11 – Display Courses Data Where duration greater than 70
SELECT * FROM courses
WHERE course_duration > 70;
-----------------------------------------------------------------------------

--12 – Display Minimum Grade to Course “PHP” 
SELECT MIN(sc.grade) AS Min
FROM students_course sc, courses c
WHERE sc.course_no = c.course_no AND c.course_name = 'PHP';
-----------------------------------------------------------------------------

--13 – Display Employee Data which supervise By Employee No 10010
SELECT * FROM employees
WHERE super_no = '10010';
-----------------------------------------------------------------------------

--14 – Display Employee Data Which earn maximum salary for all employees
SELECT * FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);
-----------------------------------------------------------------------------

--15 - Display Departments Data Which Contains More Than 200 Employees
SELECT d.*
FROM departments d
JOIN employees e ON d.dept_no = e.dept_no
GROUP BY d.dept_no
HAVING COUNT(e.emp_no) > 200;
-----------------------------------------------------------------------------

--16 – Display employee Data which earn salary greater than all Employees which first name is “Bedir”
SELECT * FROM employees
WHERE salary > (SELECT MAX(salary) FROM employees WHERE first_name = 'Bedir');
-----------------------------------------------------------------------------

--17 - Display Maximum Salary On Each Department
SELECT dept_no, MAX(salary)
FROM employees
GROUP BY dept_no;
-----------------------------------------------------------------------------

--18 - Display Departments Data Which Total Salary of employees on This Department is more than 1000000
SELECT d.*, SUM(e.salary) AS total_salary
FROM departments d
INNER JOIN employees e ON d.dept_no = e.dept_no
GROUP BY d.dept_no
HAVING total_salary > 1000000;
-----------------------------------------------------------------------------

--19 - Display Top 5 different Salary On Department "Finance"
SELECT DISTINCT e.salary
FROM employees e
JOIN departments d ON e.dept_no = d.dept_no
WHERE d.dept_name = "Finance" 
ORDER BY e.salary DESC LIMIT 5;
-----------------------------------------------------------------------------

--20 - Display Courses Which No Learning for Any Student.
SELECT courses.*
FROM courses
LEFT JOIN students_course ON courses.course_no = students_course.course_no
WHERE students_course.student_no IS NULL;
-----------------------------------------------------------------------------

--21 - Display Total Grade For All Courses With Student Name.
SELECT s.student_name, SUM(sc.grade) AS Total_grade
FROM students_course sc
JOIN students s ON sc.student_no = s.student_no
GROUP BY s.student_name;
-----------------------------------------------------------------------------

--22 - Display Departments Which Average Salary For All Employees is less than 75000.
SELECT d.*
FROM departments d
INNER JOIN employees e ON d.dept_no = e.dept_no
GROUP BY d.dept_no
HAVING AVG(e.salary) < 75000;
-----------------------------------------------------------------------------

--23 - Display Students Which Learn More Than 300 Hours.
SELECT s.*
FROM students s , courses c, students_course sc
WHERE s.student_no = sc.student_no
GROUP BY s.student_no
HAVING SUM(c.course_Duration) > 300;
-----------------------------------------------------------------------------

--24 - Using “Union” & “Multiple Fuction” Display 2 Maximum different salary.
SELECT MAX(salary) FROM employees
UNION
SELECT MAX(salary) FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);
