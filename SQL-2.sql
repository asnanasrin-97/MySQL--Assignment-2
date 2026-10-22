
USE employee;

SELECT COUNT(*) AS total_employees FROM Employees;



SELECT DISTINCT salary
FROM Employees;



SELECT employee_name,
       age    AS Employee_Age,
       salary AS Employee_Salary
FROM Employees;



SELECT *
FROM Employees
WHERE salary > 50000
  AND hire_date < '2016-01-01';


SELECT *
FROM Employees
WHERE designation IS NULL OR designation = '';

SET SQL_SAFE_UPDATES = 0;

UPDATE Employees
SET designation = 'Data Scientist'
WHERE designation IS NULL OR designation = '';


SELECT employee_id, employee_name, designation
FROM Employees
WHERE designation = 'Data Scientist';


SELECT *
FROM Employees
ORDER BY department_id ASC, salary DESC;


SELECT *
FROM Employees
WHERE hire_date >= '2018-01-01'
  AND hire_date <  '2019-01-01'
ORDER BY hire_date ASC
LIMIT 5;


SELECT SUM(e.salary) AS total_finance_salary
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';


SELECT MIN(age) AS min_age
FROM Employees;


SELECT l.location,
       MAX(e.salary) AS max_salary
FROM Employees e
JOIN Location l ON e.location_id = l.location_id
GROUP BY l.location;


SELECT designation,
       AVG(salary) AS avg_salary
FROM Employees
WHERE designation LIKE '%Analyst%'
GROUP BY designation;


SELECT d.department_id,
       d.department_name,
       COUNT(e.employee_id) AS employee_count
FROM Departments d
LEFT JOIN Employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) < 3;


SELECT l.location,
       AVG(e.age) AS avg_age
FROM Employees e
JOIN Location l ON e.location_id = l.location_id
WHERE e.gender = 'F'
GROUP BY l.location
HAVING AVG(e.age) < 30;




SELECT e.employee_name,
       e.designation,
       d.department_name
FROM Employees e
INNER JOIN Departments d ON e.department_id = d.department_id;


SELECT d.department_id,
       d.department_name,
       COUNT(e.employee_id) AS total_employees
FROM Departments d
LEFT JOIN Employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;


SELECT l.location,
       e.employee_name
FROM Employees e
RIGHT JOIN Location l ON e.location_id = l.location_id;