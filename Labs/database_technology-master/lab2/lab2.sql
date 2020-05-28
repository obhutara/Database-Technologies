--Lab 2 report <Filip Klang, filkl010 & Omkar Bhutra, omkbh878>

/*
Drop all user created tables that have been created when solving the lab
*/
DROP TABLE IF EXISTS debit_transaction;
DROP TABLE IF EXISTS withdraw_transaction;
DROP TABLE IF EXISTS deposit_transaction;
DROP TABLE IF EXISTS jbtransaction;

DROP TABLE IF EXISTS Account;
DROP TABLE IF EXISTS Customer;

ALTER TABLE Manager DROP FOREIGN KEY fk_emp_id;
ALTER TABLE jbdept DROP FOREIGN KEY fk_dept_mgr;
ALTER TABLE jbemployee DROP FOREIGN KEY fk_emp_mgr;
DROP TABLE IF EXISTS Manager;


/* Have the source scripts in the file so it is easy to recreate!*/
SOURCE company_schema.sql;
SOURCE company_data.sql;


/*
Question 3: Implement your extensions in the database by first creating tables, if any, then
populating them with existing manager data, then adding/modifying foreign key constraints. 
Do you have to initialize the bonus attribute to a value? Why?
*/

CREATE TABLE Manager (
	id INT NOT NULL,
	BonusSalary INT DEFAULT 0,
	CONSTRAINT pk_id PRIMARY KEY(id),
	CONSTRAINT fk_emp_id FOREIGN KEY(id) references jbemployee(id) 
	);

/*
Query OK, 0 rows affected (0.06 sec)
 */

INSERT INTO Manager (id) 
SELECT manager FROM jbemployee WHERE jbemployee.manager IS NOT NULL
UNION 
SELECT manager FROM jbdept WHERE jbdept.manager IS NOT NULL;

/* 
Query OK, 12 rows affected (0.04 sec)
Records: 12  Duplicates: 0  Warnings: 0
*/

/*
BonusSalary has to be initialized to a value, if not then it will be initialized to NULL which 
has to be checked if they are NULL or not which is an extra step.
*/

/* Question 4 */

UPDATE Manager
SET BonusSalary = BonusSalary+10000
WHERE id IN (SELECT manager FROM jbdept);

/*  
Query OK, 11 rows affected (0.00 sec)
Rows matched: 11  Changed: 11  Warnings: 0
*/

/*
Use alter table t1 drop foreign key constraint_name;
and alter table t2 add constraint constraint_name foreign key (t2_attribute) references t1(t1_attribute); 
to change existing foreign keys.
 */
ALTER TABLE jbemployee DROP FOREIGN KEY fk_emp_mgr;

ALTER TABLE jbemployee 
ADD CONSTRAINT fk_emp_mgr 
FOREIGN KEY (manager) REFERENCES Manager (id);

ALTER TABLE jbdept DROP FOREIGN KEY fk_dept_mgr;

ALTER TABLE jbdept 
ADD CONSTRAINT fk_dept_mgr
FOREIGN KEY (manager) REFERENCES Manager (id);

/* Question 5 */
CREATE TABLE Customer (
	id INT NOT NULL, 
	name VARCHAR(40),
	street_address VARCHAR(49),
	city INT NOT NULL,
	constraint pk_customer PRIMARY KEY (id),
	constraint fk_city FOREIGN KEY (city) REFERENCES jbcity(id)
);
/* Query OK, 0 rows affected (0.06 sec) */


CREATE TABLE Account (
	account_no INT NOT NULL,
	balance INT NOT NULL DEFAULT 0,
	customer INT NOT NULL,
	CONSTRAINT pk_account PRIMARY KEY (account_no),
	CONSTRAINT fk_cust_acc FOREIGN KEY (customer) REFERENCES Customer (id)
);


/* Query OK, 0 rows affected (0.02 sec) */


/*
We delete the old debit/sales entries to allow for some re-structuring
(If we are allowed to delete jbsale data, we must also be allowed to delete jbdebit data as they need eachother?)

These two tables are "re-implemented" into the new Transaction solution
*/
DROP TABLE jbsale;
DROP TABLE jbdebit;

CREATE TABLE jbtransaction (
	transaction_id INT NOT NULL,
	account_number INT NOT NULL,
	time_of_day TIME NOT NULL,
	transaction_date DATE NOT NULL,
	employee INT NOT NULL,

	CONSTRAINT pk_transaction PRIMARY KEY (transaction_id),
	CONSTRAINT fk_tra_emp FOREIGN KEY (employee) REFERENCES jbemployee (id)
);

/*
Query OK, 0 rows affected (0.05 sec)

*/

CREATE TABLE withdraw_transaction (
	transaction_id INT REFERENCES jbtransaction(transaction_id) ON DELETE CASCADE,
	withdraw_amount INT NOT NULL,

	CONSTRAINT pk_withdraw PRIMARY KEY (transaction_id)
);

/*
Query OK, 0 rows affected (0.05 sec)
*/

CREATE TABLE deposit_transaction (
	transaction_id INT REFERENCES jbtransaction(transaction_id) ON DELETE CASCADE,
	deposit_amount INT NOT NULL,

	CONSTRAINT pk_deposit PRIMARY KEY (transaction_id)
);

/*
Query OK, 0 rows affected (0.04 sec)
*/
CREATE TABLE debit_transaction (
	transaction_id INT REFERENCES jbtransaction(transaction_id) ON DELETE CASCADE,
	debit_amount INT NOT NULL,
	quantity INT NOT NULL,
	item INT NOT NULL,

	CONSTRAINT pk_debit PRIMARY KEY (transaction_id),
	CONSTRAINT fk_deb_ite FOREIGN KEY (item) REFERENCES jbitem (id)
);

/*
Query OK, 0 rows affected (0.05 sec)
*/
