##########################################################
##########################################################

/* Data Definition and Manipulation in SQL */

##########################################################
##########################################################


#############################
-- Task Two: Data Definition
-- In this task, you will learn how to create database objects (tables) in the database you created in task 1.
#############################

-- Creating the sales table
CREATE TABLE sales (
purchase_number INT PRIMARY KEY,
date_of_purchase DATE NOT NULL,
customer_id INT NOT NULL,
item_code VARCHAR(10) NOT NULL
);


-- Creating the customers table
CREATE TABLE customers (
customer_id INT PRIMARY KEY,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
email_address VARCHAR(255),
number_of_complaints INT
);


-- Creating the items table
CREATE TABLE items (
item_code VARCHAR(10) PRIMARY KEY,
item VARCHAR(255),
unit_price_usd DECIMAL(5,2), 
	/* this means DECIMAL length 5 and the scale is 2. 
	The precision is the total number of digits that makes up a number. 
	The scale is the number of digits after the decimal point. */
company_id INT,
company_name VARCHAR(255) NOT NULL
);

/* To verify if the tables are created correctly, in the Browser pane,
click on Databases. Then, click on sales. Then, click on Schemas. 
Then, click on Tables. The three tables created above should be reflected here. */


#############################
-- Task Three: Data Manipulation
-- By the end of Task 3, you will be able to insert records into the tables created.
#############################

-- Insert five (5) records into the sales table
-- check first what is inside the sales table
SELECT * FROM sales;
-- we'll find that there are no data yet. Let's start imputing the records.
INSERT INTO 
sales (purchase_number, date_of_purchase, customer_id, item_code)
VALUES 
(1, '2020-05-28', 1, 'A11'),
(2, '2020-05-27', 2, 'B11'),
(3, '2020-05-27', 2, 'A12'),
(4, '2020-05-31', 3, 'C11'),
(5, '2020-05-31', 4, 'B12');

--- after running the query above, check again if the data exist in the table
SELECT * FROM sales;


-- Insert five (5) records into the customers table
INSERT INTO 
customers (customer_id, first_name, last_name, email_address, number_of_complaints)
VALUES 
(1, 'Ariel', 'Felices', 'arielchristian.felices@gmail.com', 0),
(2, 'Joyce', 'Quijano', 'joycequijano@gmail.com', 2),
(3, 'Althea', 'Johanne', 'altheajohanne@mail.com', 1),
(4, 'Theodore', 'Jireh', 'theodorejireh@mail.com', 5),
(5, 'Jocelyn', 'Montes', 'jocelynmontes@mail.com', 0);

-- Retrieve data from customers table
SELECT * FROM customers;

-- Insert five (5) records into the items table
INSERT INTO
items
VALUES
('A11', 'Flask', 12.50, 1, 'Company A'),
('A12', 'Lamp', 10, 1, 'Company A'),
('B11', 'Desk', 50, 2, 'Company B'),
('B12', 'Chair', 150, 2, 'Company B'),
('C11', 'Bicycle', 35.50, 3, 'Company C');

-- Retrieve data from items table
SELECT * FROM items;

#############################
-- Task Four: Data Manipulation - Part 2
-- By the end of Task 4, you will be able to upload a csv file into your database 
-- and insert records into duplicate tables. 
#############################

-- Create the companies table and upload the CSV file into the table
CREATE TABLE companies (
company_id INT PRIMARY KEY,
company_name VARCHAR(255),
headquarters_phone_number VARCHAR(255)
);

-- Check what contains in companies table
SELECT * FROM companies;
/* We will observe that it has no content. We need to import the csv 
file for this table. To do this, in the 'Browser' pane, open the schema, 
open the tables, right click on companies table, and pick the import option.
This opened a window. Choose import. It will asks for a file name. Come over 
to the three dots, then locate the csv file for import. Next, include the 
headers, and the delimiter is a comma separated value. Then finally, 
click on OK. A prompt message that says it is succesfully imported should appear. */

-- Now, check again the content of companies table
SELECT * FROM companies;


-- Create the sales_dup table
CREATE TABLE sales_dup (
purchase_number INT PRIMARY KEY,
date_of_purchase DATE NOT NULL,
customer_id INT NOT NULL,
item_code VARCHAR(10) NOT NULL
);


-- Create the customers_dup table
CREATE TABLE customers_dup (
customer_id INT PRIMARY KEY,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
email_address VARCHAR(255),
number_of_complaints INT
);

-- In th 'Browser' pane, right-click and refresh on Tables to see the new added tables.

-- Insert records from sales table into sales_dup table
INSERT INTO sales_dup
SELECT * FROM sales;
-- all data from sales table will be copied to sales_dup table

-- retrieve data from sales_dup table
SELECT * FROM sales_dup;


-- Insert records from customers table into customers_dup table
INSERT INTO customers_dup
SELECT * FROM customers;

-- retrieve data from customers_dup table
SELECT * FROM customers_dup;


#############################
-- Task Five: Data Definition and Manipulation
-- By the end of this task, you will be able to alter, rename and update data in tables in a database.
#############################

-- Add a new column gender after the last_name field
-- We will perform this task using ALTER on the customers_dup table
ALTER TABLE customers_dup
ADD COLUMN gender CHAR(2);

-- retrieve data from the customers_dup table
SELECT * FROM customers_dup;

-- Insert new records to the customers_dup table
INSERT INTO customers_dup
VALUES 
(6, 'Isreal', 'Hawkins', 'hawkins@yahoo.com', 2, 'M'),
(7, 'Sharon', 'Metz', 'gracemt21@yahoo.com', 11, 'M');

-- retrieve again the data from the customers_dup table to see the added rows
SELECT * FROM customers_dup;

-- Rename the sales_dup table to sales_data
ALTER TABLE sales_dup
RENAME TO sales_data;
-- refresh the Table in the 'Browser' pane to verify

-- Rename the unit_price_usd column in the items table to item_price because its too long.
ALTER TABLE items
RENAME unit_price_usd TO item_price;

-- Retrieve the data from the items table
SELECT * FROM items;

-- We will UPDATE some records in the customers_dup table
-- Retrieve data from the customers_dup table
SELECT * FROM customers_dup;
-- we will notice that the first name of customer ID 6 (Isreal) is mispelled. 

-- Let's update that.
UPDATE customers_dup
SET first_name = 'Israel'
WHERE customer_id = 6;
-- specifying the WHERE clause above is mportant as it would throw an error if not.

-- Retrieve again the data from the customers_dup table to verify changes.
SELECT * FROM customers_dup;

#############################
-- Task Six: Drop Vs. Truncate Vs. Delete
-- By the end of task 6, you will learn how to use SQL drop, truncate and delete statements. 
-- In addition, you will understand the difference between SQL drop, truncate and delete statements.
#############################

/* The difference between dropping a table and truncating a table
is:
Dropping a table removes everything that relates to the table. 
Both the structure and everything.
Truncating data from a table removes only the rows but still keeps intact. */

-- DROP the customers_dup table
DROP TABLE customers_dup;

-- Retrieve data from customers_dup table
SELECT * FROM customers_dup;
/* this will throw an error because by using DROP, we delete the table completely.*/


-- TRUNCATE the sales_data table
TRUNCATE TABLE sales_data;

-- Retrieve data from sales_data table
SELECT * FROM sales_data;
/* this will return only the coulmn names of this table. By using TRUNCATE, 
we only delete the content but still keep the table intact.*/


-- DELETE records from the companies_dup table
DELETE FROM companies
WHERE company_id = 3;

-- retrieve data from companies table
SELECT * FROM companies;

-- use DELETE function again but this time w/o specifying the WHERE clause
DELETE FROM companies;

-- retrieve again the data from companies table
SELECT * FROM companies;
/* As expected. The DELETE works just like TRUNCATE without the WHERE clause.
It deletes the content but retain the table. 

Note to be careful in using WHERE clause when you are putting your 
primary key because it is the unique identifier of the table. */