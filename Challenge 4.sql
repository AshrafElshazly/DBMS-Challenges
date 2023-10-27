-- 1- Try to map the ERD and then create DB with the following Constraints
-- Salary has a default value = 3000 
-- Overtime is unique 
-- Lab is weak entity 
-- Hiredate has a default value= current system date 
-- Name of each course is unique 
-- All Name is not null

CREATE DATABASE lab2; 

CREATE TABLE instructors(
    instr_id INT PRIMARY KEY NOT NULL,
    fname VARCHAR(30) NOT NULL,
    lname VARCHAR(30) NOT NULL,
    salary INT(10) DEFAULT 3000,
    hiredate DATE DEFAULT(CURRENT_DATE),
    address VARCHAR(50),
    overtime INT(3) unique,
    bdate DATE
);

CREATE TABLE courses(
    cid INT PRIMARY KEY NOT NULL,
    cname VARCHAR(30) NOT NULL,
    duration INT(5)
);

CREATE TABLE tech(
    instr_id INT NOT NULL,
    cid INT NOT NULL,
    PRIMARY KEY (instr_id, cid),
    FOREIGN KEY (instr_id) REFERENCES instructors(instr_id),
    FOREIGN KEY (cid) REFERENCES courses(cid)
);

CREATE TABLE labs(
    lid INT NOT NULl,
    cid INT NOT NULL,
    PRIMARY KEY (lid, cid),
    location VARCHAR(50),
    capacity text,
    FOREIGN KEY (cid) REFERENCES courses(cid)
);
-----------------------------------------------------------------------------

-- 2- Update Employee By Increase Bonus to 10% of Salary For Employee In Department "Marketing". 
UPDATE employees e
JOIN departments d 
ON  e.dept_no = d.dept_no
SET  bonus = bonus*0.10
WHERE dept_name = 'Marketing'
-----------------------------------------------------------------------------

-- 3- Delete Courses Which No Students Learn it And No Employees Teach it. 
DELETE FROM courses
WHERE
course_no NOT IN (SELECT course_no FROM students_course) 
AND
course_no NOT IN (SELECT course_no FROM emp_course)
-----------------------------------------------------------------------------

-- 4- Increase Salary by 10% of it For Smallest 2 Different salaries on Employees Table. 
UPDATE employees
SET  salary = salary*0.10
WHERE salary IN (SELECT DISTINCT salary FROM employees ORDER BY salary LIMIT 2)
-----------------------------------------------------------------------------

-- 5- Display Employee Data Which Working Since More Than 30 Years 
SELECT * FROM employees
WHERE ADDDATE(hire_date,INTERVAL 30 YEAR) <= CURDATE();
-----------------------------------------------------------------------------

-- 6- Display Employee Name with title (‘No Title’ in case NULL) 
SELECT CONCAT(first_name,' ', last_name) AS Name, COALESCE(title, 'No Title') AS employee_title
FROM employees; 
-----------------------------------------------------------------------------

-- 7- Display Employee Name , age which earns no salary 
SELECT CONCAT(first_name,' ', last_name) AS Name,TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS age
FROM employees
WHERE salary IS NULL OR salary = 0;
-----------------------------------------------------------------------------

-- 8- Display Employee Name and category of hiredate 
--      New when years less than 5 years
--      old when years less than 15  
--      very old when years more than 15 

SELECT CONCAT(first_name,' ', last_name) AS Name,
CASE
    WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) < 5 THEN "New"
    WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) < 15 THEN "Old"
    WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) > 15 THEN "Very Old"
END
FROM employees;
-----------------------------------------------------------------------------

-- 9- Create view which display course name with student name 
CREATE VIEW stu_crs AS
SELECT s.student_name,c.course_name
FROM students s,courses c,students_course sc
WHERE s.student_no = sc.student_no AND c.course_no = sc.course_no
-----------------------------------------------------------------------------

-- 10- Create view which display students data and no one can change age in this view to more than 25  
CREATE VIEW students_age AS
SELECT * FROM students
WHERE age < 25 WITH CHECK OPTION;
-----------------------------------------------------------------------------
