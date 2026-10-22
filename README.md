# MySQL Assignment 2 – Querying Data

This assignment builds on the previous one (database and table creation with constraints). After populating the tables with the provided DML insert statements (Employee Data), the queries below are run to practise filtering, sorting, grouping and joining data.

## Prerequisites

1. MySQL Server and a client (MySQL Workbench, CLI, etc.)
2. The database and tables from Assignment 1 already created
3. The provided DML `INSERT` statements already executed

## Assumed Schema

> Column names below are assumptions. Adjust them to match your Assignment 1 tables.

| Table | Columns |
|---|---|
| `Employees` | `emp_id`, `emp_name`, `age`, `gender`, `salary`, `designation`, `dept_id`, `location`, `hire_date` |
| `Departments` | `dept_id`, `dept_name` |
| `Locations` | `location_name` (used for the Right Join task) |

## Topics Covered

| Section | Concepts |
|---|---|
| Distinct Values | `DISTINCT` |
| Alias | `AS` |
| Where Clause & Operators | `WHERE`, `AND`, `IS NULL`, `UPDATE` |
| Sorting | `ORDER BY` |
| Limiting | `LIMIT` |
| Aggregates | `SUM`, `MIN` |
| Grouping | `GROUP BY`, `MAX`, `AVG`, `LIKE` |
| Filtering Groups | `HAVING` |
| Joins | `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN` |

---

## Queries

### 1. Distinct Values

Retrieve distinct salaries from the Employees table.

```sql
SELECT DISTINCT salary
FROM Employees;
```

### 2. Alias (AS)

Alias `age` and `salary` as `Employee_Age` and `Employee_Salary`.

```sql
SELECT age AS Employee_Age,
       salary AS Employee_Salary
FROM Employees;
```

### 3. Where Clause & Operators

Employees with salary greater than ₹50000 and hired before 2016-01-01.

```sql
SELECT *
FROM Employees
WHERE salary > 50000
  AND hire_date < '2016-01-01';
```

Find the employee whose designation is missing and fill it with "Data Scientist".

```sql
-- Find the record(s)
SELECT *
FROM Employees
WHERE designation IS NULL OR designation = '';

-- Fill the missing value
UPDATE Employees
SET designation = 'Data Scientist'
WHERE designation IS NULL OR designation = '';
```

---

## Sorting and Grouping Data

### 1. ORDER BY

Sort by department ID ascending and salary descending.

```sql
SELECT *
FROM Employees
ORDER BY dept_id ASC, salary DESC;
```

### 2. LIMIT

First 5 employees hired in 2018.

```sql
SELECT *
FROM Employees
WHERE YEAR(hire_date) = 2018
ORDER BY hire_date ASC
LIMIT 5;
```

### 3. Aggregate Functions

Sum of all salaries in the Finance department.

```sql
SELECT SUM(e.salary) AS Total_Finance_Salary
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
WHERE d.dept_name = 'Finance';
```

Minimum age among all employees.

```sql
SELECT MIN(age) AS Minimum_Age
FROM Employees;
```

### 4. GROUP BY

Maximum salary for each location.

```sql
SELECT location,
       MAX(salary) AS Max_Salary
FROM Employees
GROUP BY location;
```

Average salary for each designation containing the word 'Analyst'.

```sql
SELECT designation,
       AVG(salary) AS Avg_Salary
FROM Employees
WHERE designation LIKE '%Analyst%'
GROUP BY designation;
```

### 5. HAVING

Departments with fewer than 3 employees.

```sql
SELECT dept_id,
       COUNT(*) AS Employee_Count
FROM Employees
GROUP BY dept_id
HAVING COUNT(*) < 3;
```

Locations with female employees whose average age is below 30.

```sql
SELECT location,
       AVG(age) AS Avg_Age
FROM Employees
WHERE gender = 'Female'
GROUP BY location
HAVING AVG(age) < 30;
```

---

## Joins

### 1. Inner Join

Employee names, designations and department names for employees assigned to a department.

```sql
SELECT e.emp_name,
       e.designation,
       d.dept_name
FROM Employees e
INNER JOIN Departments d ON e.dept_id = d.dept_id;
```

### 2. Left Join

All departments with the total number of employees, including departments with none.

```sql
SELECT d.dept_name,
       COUNT(e.emp_id) AS Total_Employees
FROM Departments d
LEFT JOIN Employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name;
```

### 3. Right Join

All locations with the names of employees assigned to each (NULL if none).

```sql
SELECT l.location_name,
       e.emp_name
FROM Employees e
RIGHT JOIN Locations l ON e.location = l.location_name;
```

---

## How to Run

1. Select your database: `USE your_database_name;`
2. Run the DML insert script to load the data.
3. Execute each query above and verify the output.

## Notes

- Run the `UPDATE` statement only after reviewing the `SELECT` result, to confirm it affects the intended row.
- If `location` is stored in a separate table in your schema, adjust the `GROUP BY` and Right Join queries to join through that table.
