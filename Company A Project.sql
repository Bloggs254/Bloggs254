CREATE TABLE employee (
emp_id int PRIMARY KEY,
first_name varchar(40),
last_name varchar(40),
birth_day DATE,
sex varchar(1),
salary int,
super_id int,
branch_id int
)

CREATE TABLE branch (
branch_id INT PRIMARY KEY,
branch_name VARCHAR(40),
mgr_id int,
mgr_start_date DATE,
FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
)

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD CONSTRAINT FK_employee_branch
FOREIGN KEY (branch_id) 
REFERENCES branch(branch_id);

CREATE TABLE client (
client_id INT PRIMARY KEY,
client_name VARCHAR(40),
 branch_id INT,
 FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
)

CREATE TABLE works_with (
emp_id INT,
client_id INT,
total_sales INT,
 RIMARY KEY(emp_id, client_id),
FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
)

CREATE TABLE branch_supplier (
branch_id INT,
supplier_name VARCHAR(40),
supply_type VARCHAR(40),
PRIMARY KEY(branch_id, supplier_name),
FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
)


INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

--UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

--INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

---- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


 BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Label', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Label', 'Custom Forms');

---- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

---- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

Find all employee's id's and names who were born after 1969

Select COUNT(emp_id)
From employee
WHERE sex = 'F' AND birth_day > '1970-01-01'

Find all employees who are female & born after 1969 or who make over 80000

Select *
FROM employee
WHERE (birth_day > = '1970-01-01' AND sex ='F') OR salary > 80000;

--find the number of employees

 Select COUNT(emp_id)
From employee

--Find the average of all employee's salary
Select AVG (salary)
From employee

--Find the average of all employee's salary where gender is Male
Select AVG (salary)
From employee
WHERE sex = 'M'

--Finding how many males and females are there 
Select COUNT (sex), sex
From employee
Group by sex

--Finfing how much money company spends on salaries

Select SUM (salary)
From employee

--Find sum of total sales of each sales man
Select SUM (total_sales), emp_id
From works_with 
Group by emp_id

-- Find all employees ordered by salary Acending order
SELECT*
 FROM employee
 ORDER BY salary ASC

 --find the number of employees who have super visers 
 SELECT COUNT (super_id)
 FROM employee

 FIND ANY CLIENTS WHO ARE ON LLC
SELECT*
FROM client
WHERE client_name LIKE '%LLC'

find list of employee and branch names

SELECT first_name
From employee
UNION
SELECT branch_name
From branch
UNION
SELECT client_name
From client

 Find any employee born on the 10th day of the month
SELECT *
FROM employee
WHERE birth_day LIKE '_____10%'

 s the extra branch
INSERT INTO branch VALUES (4, 'Buffalo', NULL,NULL)

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch 
ON employee.emp_id = branch.mgr_id;


--Find names of all employees who have sold over 50,000

SELECT works_with.emp_id
FROM works_with
where works_with.total_sales > 50000

Find names of all employees who have sold over 50,000 to a single client

SELECT employee.first_name, employee.last_name
From employee
WHERE employee.emp_id IN (
    SELECT works_with.emp_id
     FROM works_with
	 where works_with.total_sales > 50000
)

