DROP DATABASE IF EXISTS company;
CREATE DATABASE company;
USE company;

CREATE TABLE IF NOT EXISTS department (
  department_id INT NOT NULL AUTO_INCREMENT,
  department_name VARCHAR(30) NOT NULL UNIQUE,
  city VARCHAR(30) NOT NULL DEFAULT 'Lviv',
  street VARCHAR(50),                  
  building_no INT NOT NULL,                     
  PRIMARY KEY (department_id)
);


CREATE TABLE IF NOT EXISTS employee (
  employee_id INT NOT NULL AUTO_INCREMENT,
  user_name VARCHAR(50) NOT NULL UNIQUE,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  position VARCHAR(50),
  employment_date DATE,
  department_id INT,          
  manager_id INT,
  rate DECIMAL(10,2) NOT NULL,
  bonus DECIMAL(10,2),
  PRIMARY KEY (employee_id)
);

CREATE TABLE IF NOT EXISTS customer (
  customer_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  gender CHAR(1),
  birth_date DATE,
  phone_number VARCHAR(20) UNIQUE, 
  email VARCHAR(100) UNIQUE,
  discount INT,
  PRIMARY KEY (customer_id)
);

CREATE TABLE IF NOT EXISTS product (
  product_id INT NOT NULL AUTO_INCREMENT,
  product_name VARCHAR(100) NOT NULL,
  product_description VARCHAR(255),
  category VARCHAR(50),
  manufacture VARCHAR(50),
  product_type VARCHAR(50),
  amount INT,
  price DECIMAL(10,2),
  PRIMARY KEY (product_id)
);

CREATE TABLE IF NOT EXISTS invoice (
  invoice_id BIGINT NOT NULL,         
  employee_id INT,                      
  customer_id INT,                    
  payment_method TINYINT,
  transaction_moment DATETIME,
  status varchar(10) NOT NULL,
  PRIMARY KEY (invoice_id)
);


CREATE TABLE IF NOT EXISTS orders (
  orders_id INT NOT NULL AUTO_INCREMENT,
  invoice_id BIGINT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  order_datetime DATETIME NOT NULL,   
  PRIMARY KEY (orders_id)
);

ALTER TABLE employee
  ADD CONSTRAINT fk_employee_department FOREIGN KEY (department_id) REFERENCES department(department_id),
  ADD CONSTRAINT fk_employee_manager FOREIGN KEY (manager_id) REFERENCES employee(employee_id);

ALTER TABLE invoice
  ADD CONSTRAINT fk_invoice_employee FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
  ADD CONSTRAINT fk_invoice_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

ALTER TABLE orders
  ADD CONSTRAINT fk_orders_invoice FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
  ADD CONSTRAINT fk_orders_product FOREIGN KEY (product_id) REFERENCES product(product_id);
  
SELECT * FROM department;
SELECT * FROM employee;
SELECT * FROM customer;
SELECT * FROM product;
SELECT * FROM invoice;
SELECT * FROM orders;

INSERT INTO department (department_name, city, street, building_no) VALUES
('Sun', 'Lviv', 'Shevchenko', 10),
('Moon', 'Kyiv', 'Khreshchatyk', 25),
('Mercury', 'Odessa', 'Deribasivska', 15),
('Venus', 'Lviv', 'Halytska', 5);

INSERT INTO employee (user_name, first_name, last_name, position, employment_date, department_id, manager_id, rate, bonus) VALUES
('martynenko_l', 'Lyubomyr', 'Martynenko', 'CEO', '1998-01-01', 1, NULL, 5000.00, 1000.00),
('kryvonis_v', 'Vladyslav', 'Kryvonis', 'Manager', '2013-03-22', 1, 1, 3500.00, 500.00),
('hrytsenko_a', 'Alina', 'Hrytsenko', 'Manager', '2016-10-04', 2, 1, 3400.00, 450.00),
('stepanova_m', 'Myroslav', 'Stepanova', 'Manager', '1999-08-05', 3, 1, 3300.00, 400.00);

INSERT INTO employee (user_name, first_name, last_name, position, employment_date, department_id, manager_id, rate, bonus) VALUES
('sirenko_l', 'Lina', 'Sirenko', 'Financial Analitic', '2016-08-20', 1, 1, 2500.00, 100.00),
('zayika_o', 'Oksana', 'Zayika', 'Accountant', '2007-10-24', 1, 1, 2400.00, 100.00),
('tymchuk_ya', 'Yaroslav', 'Tymchuk', 'Human Resources', '2018-01-11', 1, 2, 2300.00, 50.00),
('tarasyuk_h', 'Hanna', 'Tarasyuk', 'Marketing Specialist', '2003-02-08', 3, 4, 2200.00, 50.00),
('demchuk_v', 'Viktor', 'Demchuk', 'Consultant', '2022-09-11', 4, 3, 1800.00, 10.00),
('lysyuk_y', 'Yaroslav', 'Lysyuk', 'Consultant', '2022-09-05', 4, 3, 1800.00, 10.00);

INSERT INTO customer (first_name, last_name, gender, birth_date, phone_number, email, discount) VALUES
('Zynovij', 'Kohut', 'M', '1985-05-15', '380671111111', 'zkohut@example.com', 10),
('Vita', 'Dudnyk', 'F', '1990-11-20', '380502222222', 'vdudnyk@example.com', 5),
('Eduard', 'Usenko', 'M', '1976-01-01', '380933333333', 'eusenko@example.com', 15),
('Tamara', 'Ilchenko', 'F', '2000-03-10', '380684444444', 'tilchenko@example.com', 0),
('Myroslav', 'Kravchenko', 'M', '1995-07-25', '380965555555', 'mkravch@example.com', 10),
('Marta', 'Noorders', 'F', '1999-04-01', '380976666666', 'marta@example.com', 0);

INSERT INTO product (product_id, product_name, product_description, category, manufacture, product_type, amount, price) VALUES
(1, 'Laptop Pro', 'Powerful business laptop', 'Electronics', 'TechCorp', 'Laptop', 50, 25000.00),
(2, 'Mechanical Keyboard', 'Gaming keyboard', 'Electronics', 'GameGear', 'Peripheral', 100, 3500.00),
(3, 'Office Chair Ergonomic', 'Comfortable chair', 'Furniture', 'ErgoFurn', 'Chair', 20, 8000.00),
(4, 'Monitor 27-inch', '4K display', 'Electronics', 'TechCorp', 'Monitor', 30, 12000.00);

INSERT INTO invoice (invoice_id, employee_id, customer_id, payment_method, transaction_moment, status) VALUES
(20220902081028, 9, 1, 1, '2022-09-02 08:10:28', 'Paid'),
(20220903091341, 10, 2, 1, '2022-09-03 09:13:41', 'Paid'),
(20220905101747, 10, NULL, 2, '2022-09-05 10:17:47', 'Paid'),
(20220906092712, 9, 3, 1, '2022-09-06 09:27:12', 'Paid'),
(20230801120000, 4, 5, 1, '2023-08-01 12:00:00', 'Paid');

INSERT INTO orders (invoice_id, product_id, quantity, order_datetime) VALUES
(20220902081028, 1, 1, '2022-09-02 08:10:28'),
(20220902081028, 2, 2, '2022-09-02 08:10:28'),
(20220903091341, 3, 1, '2022-09-03 09:13:41'),
(20220905101747, 4, 1, '2022-09-05 10:17:47'),
(20220906092712, 1, 1, '2022-09-06 09:27:12'),
(20230801120000, 2, 3, '2023-08-01 12:00:00');

SELECT
  employee_id AS "Manager ID",
  last_name AS "Manager Last Name",
  first_name AS 'Manager First Name',
  position AS 'Manager Title',
  employment_date AS 'Manager Hire Date'
FROM
  employee AS Managers
WHERE
  position IN ('CEO', 'Manager');

SELECT
  e.employee_id AS "Employee ID",
  e.last_name AS "Employee Last Name",
  e.first_name AS 'Employee First Name',
  e.position AS 'Employee Title',
  e.employment_date AS 'Employee Hire Date',
  e.manager_id AS "Employee Manager ID",
  m.employee_id AS "Manager ID",
  m.last_name AS "Manager Last Name",
  m.first_name AS 'Manager First Name',
  m.position AS 'Manager Title',
  m.employment_date AS 'Manager Hire Date'
FROM
  employee AS e,
  employee AS m
WHERE
  e.manager_id = m.employee_id;

SELECT
  e.employee_id AS "Employee ID",
  e.last_name AS "Employee Last Name",
  e.first_name AS 'Employee First Name',
  e.position AS 'Employee Title',
  e.department_id AS "Employee Department ID",
  d.department_id AS "Department ID",
  d.department_name AS "Department Name"
FROM
  employee AS e,
  department AS d
WHERE
  e.department_id = d.department_id;

SELECT
  e.employee_id AS "Employee ID",
  e.last_name AS "Employee Last Name",
  e.first_name AS 'Employee First Name',
  e.position AS 'Employee Title',
  i.employee_id AS "Invoice Employee ID",
  i.invoice_id AS 'Invoice',
  i.transaction_moment AS 'Transaction moment'
FROM
  employee AS e
INNER JOIN invoice AS i
ON e.employee_id = i.employee_id
ORDER BY
  i.transaction_moment;

SELECT
  e.employee_id AS "Employee ID",
  e.last_name AS "Employee Last Name",
  e.first_name AS 'Employee First Name',
  e.position AS 'Employee Title',
  i.employee_id AS "Invoice Employee ID",
  i.invoice_id AS 'Invoice',
  i.transaction_moment AS 'Transaction moment'
FROM
  employee AS e
NATURAL JOIN invoice AS i
ORDER BY
  i.transaction_moment;

SELECT
  e.employee_id AS "Employee ID",
  e.last_name AS "Employee Last Name",
  e.first_name AS 'Employee First Name',
  e.position AS 'Employee Title',
  i.employee_id AS "Invoice Employee ID",
  i.invoice_id AS 'Invoice',
  i.customer_id AS 'Invoice Customer ID',
  i.transaction_moment AS 'Transaction moment',
  c.customer_id AS 'Customer ID',
  c.last_name AS 'Customer Last Name',
  c.first_name AS 'Customer First Name'
FROM
  employee AS e
NATURAL JOIN invoice AS i
JOIN customer AS c
USING (customer_id)
ORDER BY
  i.transaction_moment;

SELECT
  e.employee_id AS "Employee ID",
  e.last_name AS "Employee Last Name",
  e.first_name AS 'Employee First Name',
  e.position AS 'Employee Title',
  i.invoice_id AS 'Invoice',
  i.customer_id AS 'Invoice Customer ID',
  i.transaction_moment AS 'Transaction moment',
  c.customer_id AS 'Customer ID',
  c.last_name AS 'Customer Last Name',
  c.first_name AS 'Customer First Name'
FROM
  employee AS e
NATURAL JOIN invoice AS i
LEFT JOIN customer AS c
USING (customer_id)
WHERE
  c.customer_id IS NULL
ORDER BY
  i.transaction_moment;

SELECT
  e.employee_id AS 'Employee ID',
  e.last_name AS 'Employee Last Name',
  e.first_name AS 'Employee First Name',
  e.position AS 'Employee position',
  e.manager_id AS 'Employee Manager ID',
  e.department_id AS 'Employee department ID',
  m.employee_id AS 'Manager ID',
  m.last_name AS 'Manager Last Name',
  m.first_name AS 'Manager First Name',
  m.position AS 'Manager position',
  m.department_id AS 'Manager Department ID',
  d.department_id AS 'Department ID',
  d.department_name AS 'Department Name',
  d.city AS 'Department City'
FROM
  department AS d
RIGHT JOIN employee AS e
  ON e.department_id = d.department_id
LEFT JOIN employee AS m
  ON e.manager_id = m.employee_id;

SELECT
  employee_id,
  first_name,
  last_name,
  position,
  'Consulting' AS Responsibility
FROM
  employee
WHERE
  position LIKE '%Consultant%'
UNION
SELECT
  employee_id,
  first_name,
  last_name,
  position,
  'Not Consulting' AS Responsibility
FROM
  employee
WHERE
  position NOT LIKE '%Consultant%'
ORDER BY
  last_name;

SELECT
  o.orders_id AS 'Orders ID',
  p.product_name AS 'Product name',
  p.category AS 'Product category',
  i.invoice_id AS 'Invoice ID',
  i.transaction_moment AS 'Transaction moment',
  c.last_name AS 'Customer last name',
  c.first_name AS 'Customer first name'
FROM
  orders AS o
INNER JOIN product AS p ON o.product_id = p.product_id
INNER JOIN invoice AS i ON o.invoice_id = i.invoice_id
LEFT JOIN customer AS c ON i.customer_id = c.customer_id
ORDER BY
  o.orders_id;

SELECT
  o.orders_id AS 'Orders ID',
  p.product_name AS 'Product name',
  p.category AS 'Product category',
  i.invoice_id AS 'Invoice ID',
  i.transaction_moment AS 'Transaction moment',
  c.last_name AS 'Customer last name',
  c.first_name AS 'Customer first name',
  e.last_name AS 'Employee last name',
  d.department_name AS 'Department'
FROM
  orders AS o
INNER JOIN product AS p ON o.product_id = p.product_id
INNER JOIN invoice AS i ON o.invoice_id = i.invoice_id
INNER JOIN employee AS e ON i.employee_id = e.employee_id
INNER JOIN department AS d ON e.department_id = d.department_id
LEFT JOIN customer AS c ON i.customer_id = c.customer_id
WHERE
  d.department_name = 'Mercury'
  AND i.transaction_moment BETWEEN '2023-07-01' AND '2023-10-01'
ORDER BY
  o.orders_id;

(
  SELECT
    c.customer_id AS 'Customer ID',
    c.last_name AS 'Last Name',
    c.first_name AS 'First Name',
    i.invoice_id AS 'Invoice ID',
    i.transaction_moment AS 'Transaction Moment'
  FROM
    customer AS c
  LEFT JOIN invoice AS i ON c.customer_id = i.customer_id
)
UNION
(
  SELECT
    c.customer_id AS 'Customer ID',
    c.last_name AS 'Last Name',
    c.first_name AS 'First Name',
    i.invoice_id AS 'Invoice ID',
    i.transaction_moment AS 'Transaction Moment'
  FROM
    customer AS c
  RIGHT JOIN invoice AS i ON c.customer_id = i.customer_id
  WHERE
    c.customer_id IS NULL
)
ORDER BY
  'Invoice ID';