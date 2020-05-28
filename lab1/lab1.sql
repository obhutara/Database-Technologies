/*
Lab 1 report <Filip Klang, filkl010 & Omkar Bhutra, omkbh878>
*/

/*
Drop all user created tables that have been created when solving the lab
*/
DROP TABLE IF EXISTS custom_item;

DROP VIEW less_avg_view;
DROP VIEW total_debit_cost;
DROP VIEW total_debit_cost_join;


/* Have the source scripts in the file so it is easy to recreate!*/

SOURCE company_schema.sql;
SOURCE company_data.sql;

/*
Question 1: List all employees, i.e. all tuples in the jbemployeerelation.
*/

SELECT * FROM jbemployee;

/*
+------+--------------------+--------+---------+-----------+-----------+
| id   | name               | salary | manager | birthyear | startyear |
+------+--------------------+--------+---------+-----------+-----------+
|   10 | Ross, Stanley      |  15908 |     199 |      1927 |      1945 |
|   11 | Ross, Stuart       |  12067 |    NULL |      1931 |      1932 |
|   13 | Edwards, Peter     |   9000 |     199 |      1928 |      1958 |
|   26 | Thompson, Bob      |  13000 |     199 |      1930 |      1970 |
|   32 | Smythe, Carol      |   9050 |     199 |      1929 |      1967 |
|   33 | Hayes, Evelyn      |  10100 |     199 |      1931 |      1963 |
|   35 | Evans, Michael     |   5000 |      32 |      1952 |      1974 |
|   37 | Raveen, Lemont     |  11985 |      26 |      1950 |      1974 |
|   55 | James, Mary        |  12000 |     199 |      1920 |      1969 |
|   98 | Williams, Judy     |   9000 |     199 |      1935 |      1969 |
|  129 | Thomas, Tom        |  10000 |     199 |      1941 |      1962 |
|  157 | Jones, Tim         |  12000 |     199 |      1940 |      1960 |
|  199 | Bullock, J.D.      |  27000 |    NULL |      1920 |      1920 |
|  215 | Collins, Joanne    |   7000 |      10 |      1950 |      1971 |
|  430 | Brunet, Paul C.    |  17674 |     129 |      1938 |      1959 |
|  843 | Schmidt, Herman    |  11204 |      26 |      1936 |      1956 |
|  994 | Iwano, Masahiro    |  15641 |     129 |      1944 |      1970 |
| 1110 | Smith, Paul        |   6000 |      33 |      1952 |      1973 |
| 1330 | Onstad, Richard    |   8779 |      13 |      1952 |      1971 |
| 1523 | Zugnoni, Arthur A. |  19868 |     129 |      1928 |      1949 |
| 1639 | Choy, Wanda        |  11160 |      55 |      1947 |      1970 |
| 2398 | Wallace, Maggie J. |   7880 |      26 |      1940 |      1959 |
| 4901 | Bailey, Chas M.    |   8377 |      32 |      1956 |      1975 |
| 5119 | Bono, Sonny        |  13621 |      55 |      1939 |      1963 |
| 5219 | Schwarz, Jason B.  |  13374 |      33 |      1944 |      1959 |
+------+--------------------+--------+---------+-----------+-----------+
25 rows in set (0.01 sec)
*/



/*
Question 2: List the name of all departments in alphabetical order
*/

SELECT * FROM jbdept ORDER BY name;

/*
+----+------------------+-------+-------+---------+
| id | name             | store | floor | manager |
+----+------------------+-------+-------+---------+
|  1 | Bargain          |     5 |     0 |      37 |
| 35 | Book             |     5 |     1 |      55 |
| 10 | Candy            |     5 |     1 |      13 |
| 73 | Children's       |     5 |     1 |      10 |
| 43 | Children's       |     8 |     2 |      32 |
| 19 | Furniture        |     7 |     4 |      26 |
| 99 | Giftwrap         |     5 |     1 |      98 |
| 14 | Jewelry          |     8 |     1 |      33 |
| 47 | Junior Miss      |     7 |     2 |     129 |
| 65 | Junior's         |     7 |     3 |      37 |
| 26 | Linens           |     7 |     3 |     157 |
| 20 | Major Appliances |     7 |     4 |      26 |
| 58 | Men's            |     7 |     2 |     129 |
| 60 | Sportswear       |     5 |     1 |      10 |
| 34 | Stationary       |     5 |     1 |      33 |
| 49 | Toys             |     8 |     2 |      35 |
| 63 | Women's          |     7 |     3 |      32 |
| 70 | Women's          |     5 |     1 |      10 |
| 28 | Women's          |     8 |     2 |      32 |
+----+------------------+-------+-------+---------+
19 rows in set (0.00 sec)
*/



/*
Question 3: What parts are not in store, i.e. qoh=0? (qoh= Quantity On Hand)
*/

SELECT * FROM jbparts WHERE qoh=0;

/*
+----+-------------------+-------+--------+------+
| id | name              | color | weight | qoh  |
+----+-------------------+-------+--------+------+
| 11 | card reader       | gray  |    327 |    0 |
| 12 | card punch        | gray  |    427 |    0 |
| 13 | paper tape reader | black |    107 |    0 |
| 14 | paper tape punch  | black |    147 |    0 |
+----+-------------------+-------+--------+------+
4 rows in set (0.00 sec)
*/



/*
Question 4: Which employees have a salary between 9000(included)and 10000(included)?
*/

SELECT * FROM jbemployee WHERE salary BETWEEN 9000 and 10000;

/*
+-----+----------------+--------+---------+-----------+-----------+
| id  | name           | salary | manager | birthyear | startyear |
+-----+----------------+--------+---------+-----------+-----------+
|  13 | Edwards, Peter |   9000 |     199 |      1928 |      1958 |
|  32 | Smythe, Carol  |   9050 |     199 |      1929 |      1967 |
|  98 | Williams, Judy |   9000 |     199 |      1935 |      1969 |
| 129 | Thomas, Tom    |  10000 |     199 |      1941 |      1962 |
+-----+----------------+--------+---------+-----------+-----------+
4 rows in set (0.00 sec)

*/



/*
Question 5: What was the age of each employee when they started working (startyear)?
*/

SELECT *, (startyear-birthyear) as starting_age FROM jbemployee;

/*
+------+--------------------+--------+---------+-----------+-----------+--------------+
| id   | name               | salary | manager | birthyear | startyear | starting_age |
+------+--------------------+--------+---------+-----------+-----------+--------------+
|   10 | Ross, Stanley      |  15908 |     199 |      1927 |      1945 |           18 |
|   11 | Ross, Stuart       |  12067 |    NULL |      1931 |      1932 |            1 |
|   13 | Edwards, Peter     |   9000 |     199 |      1928 |      1958 |           30 |
|   26 | Thompson, Bob      |  13000 |     199 |      1930 |      1970 |           40 |
|   32 | Smythe, Carol      |   9050 |     199 |      1929 |      1967 |           38 |
|   33 | Hayes, Evelyn      |  10100 |     199 |      1931 |      1963 |           32 |
|   35 | Evans, Michael     |   5000 |      32 |      1952 |      1974 |           22 |
|   37 | Raveen, Lemont     |  11985 |      26 |      1950 |      1974 |           24 |
|   55 | James, Mary        |  12000 |     199 |      1920 |      1969 |           49 |
|   98 | Williams, Judy     |   9000 |     199 |      1935 |      1969 |           34 |
|  129 | Thomas, Tom        |  10000 |     199 |      1941 |      1962 |           21 |
|  157 | Jones, Tim         |  12000 |     199 |      1940 |      1960 |           20 |
|  199 | Bullock, J.D.      |  27000 |    NULL |      1920 |      1920 |            0 |
|  215 | Collins, Joanne    |   7000 |      10 |      1950 |      1971 |           21 |
|  430 | Brunet, Paul C.    |  17674 |     129 |      1938 |      1959 |           21 |
|  843 | Schmidt, Herman    |  11204 |      26 |      1936 |      1956 |           20 |
|  994 | Iwano, Masahiro    |  15641 |     129 |      1944 |      1970 |           26 |
| 1110 | Smith, Paul        |   6000 |      33 |      1952 |      1973 |           21 |
| 1330 | Onstad, Richard    |   8779 |      13 |      1952 |      1971 |           19 |
| 1523 | Zugnoni, Arthur A. |  19868 |     129 |      1928 |      1949 |           21 |
| 1639 | Choy, Wanda        |  11160 |      55 |      1947 |      1970 |           23 |
| 2398 | Wallace, Maggie J. |   7880 |      26 |      1940 |      1959 |           19 |
| 4901 | Bailey, Chas M.    |   8377 |      32 |      1956 |      1975 |           19 |
| 5119 | Bono, Sonny        |  13621 |      55 |      1939 |      1963 |           24 |
| 5219 | Schwarz, Jason B.  |  13374 |      33 |      1944 |      1959 |           15 |
+------+--------------------+--------+---------+-----------+-----------+--------------+
25 rows in set (0.00 sec)

*/



/*
Question 6: Which employees have a last name ending with “son”?
*/

SELECT * FROM jbemployee WHERE name LIKE '%son,%';

/*
+----+---------------+--------+---------+-----------+-----------+
| id | name          | salary | manager | birthyear | startyear |
+----+---------------+--------+---------+-----------+-----------+
| 26 | Thompson, Bob |  13000 |     199 |      1930 |      1970 |
+----+---------------+--------+---------+-----------+-----------+
1 row in set (0.00 sec)

*/



/*
Question 7: Which items (note items, not parts) have been delivered by a supplier called Fisher-Price? Formulate this query using a subquery in the where-clause.
*/

SELECT * FROM jbitem WHERE supplier = (SELECT id FROM jbsupplier WHERE name='Fisher-Price');

/*
+-----+-----------------+------+-------+------+----------+
| id  | name            | dept | price | qoh  | supplier |
+-----+-----------------+------+-------+------+----------+
|  43 | Maze            |   49 |   325 |  200 |       89 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 |
+-----+-----------------+------+-------+------+----------+
3 rows in set (0.01 sec)

*/



/*
Question 8: Formulate the same query as above, but without a subquery.
*/

SELECT 
    * 
FROM jbitem 
LEFT JOIN jbsupplier ON jbitem.supplier = jbsupplier.id 
WHERE jbsupplier.name = 'Fisher-Price';


/*
+-----+-----------------+------+-------+------+----------+----+--------------+------+
| id  | name            | dept | price | qoh  | supplier | id | name         | city |
+-----+-----------------+------+-------+------+----------+----+--------------+------+
|  43 | Maze            |   49 |   325 |  200 |       89 | 89 | Fisher-Price |   21 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 | 89 | Fisher-Price |   21 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 | 89 | Fisher-Price |   21 |
+-----+-----------------+------+-------+------+----------+----+--------------+------+
3 rows in set (0.01 sec)

*/



/*
Question 9: Show all cities that have suppliers located in them. Formulate this query using a subquery in the where-clause.
*/

SELECT 
    * 
FROM jbcity 
WHERE id IN (SELECT city FROM jbsupplier);

/*
+-----+----------------+-------+
| id  | name           | state |
+-----+----------------+-------+
|  10 | Amherst        | Mass  |
|  21 | Boston         | Mass  |
| 100 | New York       | NY    |
| 106 | White Plains   | Neb   |
| 118 | Hickville      | Okla  |
| 303 | Atlanta        | Ga    |
| 537 | Madison        | Wisc  |
| 609 | Paxton         | Ill   |
| 752 | Dallas         | Tex   |
| 802 | Denver         | Colo  |
| 841 | Salt Lake City | Utah  |
| 900 | Los Angeles    | Calif |
| 921 | San Diego      | Calif |
| 941 | San Francisco  | Calif |
| 981 | Seattle        | Wash  |
+-----+----------------+-------+
15 rows in set (0.00 sec)

*/



/*
Question 10: What is the name and color of the parts that are heavier than a card reader? 
Formulate this query using a subquery in the where-clause. (The SQL query must not contain the weight as a constant.)
*/

SELECT name, color FROM jbparts WHERE weight > (SELECT weight FROM jbparts WHERE name='card reader');

/*
+--------------+--------+
| name         | color  |
+--------------+--------+
| disk drive   | black  |
| tape drive   | black  |
| line printer | yellow |
| card punch   | gray   |
+--------------+--------+
4 rows in set (0.00 sec)

*/



/*
Question 11: Formulate the same query as above, but without a subquery. 
(The query must not contain the weight as a constant.)
*/

SELECT 
    I.name as "INAME", 
    I.color as "ICOLOR" 
FROM 
    jbparts I, 
    jbparts C 
WHERE I.weight > C.weight AND C.name='card reader';

/*
+--------------+--------+
| INAME        | ICOLOR |
+--------------+--------+
| disk drive   | black  |
| tape drive   | black  |
| line printer | yellow |
| card punch   | gray   |
+--------------+--------+
4 rows in set (0.00 sec)

*/



/*
Question 12: What is the average weight of black parts?
*/

SELECT 
    AVG(weight) 
FROM 
    jbparts 
WHERE color='black';

/*
+-------------+
| AVG(weight) |
+-------------+
|    347.2500 |
+-------------+
1 row in set (0.00 sec)

*/



/*
Question 13: What is the total weight of all parts that each supplier in Massachusetts (“Mass”) has delivered? 
Retrieve the name and the total weight for each of these suppliers. Do not forget to take the quantity of delivered parts into account. 
Note that one row should be returned for each supplier.
*/

SELECT
    jbsupplier.name as supplier_name,
    jbcity.state as city_state,
    SUM(jbsupply.quan*jbparts.weight) as total_supply_weight
FROM
    jbsupplier
LEFT JOIN jbcity ON jbsupplier.city = jbcity.id
INNER JOIN jbsupply ON jbsupplier.id = jbsupply.supplier
LEFT JOIN jbparts ON jbsupply.part = jbparts.id
WHERE jbcity.state = 'mass'
GROUP BY jbsupplier.id;

/*
+---------------+------------+---------------------+
| supplier_name | city_state | total_supply_weight |
+---------------+------------+---------------------+
| Fisher-Price  | Mass       |             1135000 |
| DEC           | Mass       |                3120 |
+---------------+------------+---------------------+
2 rows in set (0.00 sec)

*/



/*
Question 14: Create a new relation (a table), 
with the same attributes as the table items using the CREATE TABLE syntax where you define every attribute explicitly (i.e. not as a copy of another table). 
Then fill the table with all items that cost less than the average price for items. 
Remember to define primary and foreign keys in your table!
*/

CREATE TABLE custom_item (
    id int(11) NOT NULL, 
    name varchar(20), 
    dept int(11) NOT NULL, 
    price int(11), 
    qoh int(10) UNSIGNED, 
    supplier int(11) NOT NULL, 

constraint pk_custom_item 
    primary key (id), 

constraint fk_custom_item_dept
    FOREIGN KEY (dept) references jbdept(id), 

constraint fk_custom_item_supplier 
    FOREIGN KEY(supplier) references jbsupplier(id)
);

INSERT INTO 
    custom_item 
SELECT 
    * 
FROM 
    jbitem 
WHERE price < (SELECT AVG(price) FROM jbitem);

/*
Query OK, 0 rows affected (0.05 sec)
*/

/*
Query OK, 14 rows affected (0.01 sec)
Records: 14  Duplicates: 0  Warnings: 0
*/



/*
Question 15: Create a view that contains the items that cost less than the average price for items.
*/

CREATE VIEW less_avg_view AS 
SELECT 
    * 
FROM 
    jbitem 
WHERE price < (SELECT AVG(price) FROM jbitem);

-- If one wants to see the contents of the view
-- SELECT * FROM less_avg_view;

/*
Query OK, 0 rows affected (0.03 sec)
*/

/*
Question 16: What is the difference between a table and a view? One is static and the other is dynamic. 
Which is which and what do we mean by static respectively dynamic?
*/

/*
A standard database table can be considered static in a sense that all data is “as is”. 
There is nothing else but pure, standardized data. 
A View however, is a layer of abstraction of a database table that “dynamically” updates when the table itself is updated. 
A view can contain query results of a table, that will dynamically update when data in the table is changed. 

A view can also help end-users with data handling as all relevant data can be computed and put into a simplified view.
*/

/*
Question 17: Create a view, using only the implicit join notation, i.e. only use where statements but no inner join, right join or left join statements, 
that calculates the total cost of each debit, by considering price and quantity of each bought item. 
(To be used for charging customer accounts). 
The view should contain the sale identifier (debit) and total cost.
*/

CREATE VIEW total_debit_cost AS
SELECT
    debit,
    SUM( (SELECT price FROM jbitem WHERE jbsale.item = jbitem.id)*quantity) AS total_item_cost
FROM jbsale
GROUP BY debit;

-- If one wants to see the contents of the view
-- SELECT * FROM total_debit_cost;

/*
Query OK, 0 rows affected (0.04 sec)
*/



/*
Question 18: Do the same as in (17), using only the explicit join notation, 
i.e. using only left, right or inner joins but no where statement. 
Motivate why you use the join you do (left, right or inner), and why this is the correct one (unlike the others).
*/

/*
In the query below, we decided to do a left join because that we want all the corresponding data in jbitem that we have in jbsale.
(We want all the records in the left table (jbsale) and the matched records from the right table (jbitem))
*/
CREATE VIEW total_debit_cost_join AS
SELECT
    debit,
    SUM(quantity*jbitem.price) AS total_debit_cost
FROM jbsale
LEFT JOIN jbitem ON jbitem.id=jbsale.item
GROUP BY debit;

-- If one wants to see the contents of the view
-- SELECT * FROM total_debit_cost_join;

/*
Query OK, 0 rows affected (0.06 sec)
*/



/*
19 Oh no! An earthquake!
    a) Remove all suppliers in Los Angeles from the table jbsupplier. 
    This will not work right away(you will receive error code 23000)which you will have to solve by deleting some other related tuples. 
    However, do not delete more tuples from other tables than necessary and do not change the structure of the tables, 
    i.e. do not remove foreign keys.
    Also, remember that you are only allowed to use “Los Angeles” as a constant in your queries, not “199” or “900”.
*/


DELETE FROM jbsale
WHERE item IN 
    (SELECT id FROM jbitem WHERE supplier IN
        (SELECT id from jbsupplier WHERE city=
            (SELECT id FROM jbcity WHERE name='Los Angeles')));

DELETE FROM jbitem
WHERE supplier IN
    (SELECT id from jbsupplier WHERE city=
        (SELECT id FROM jbcity WHERE name='Los Angeles'));

DELETE FROM custom_item 
WHERE supplier IN
    (SELECT id from jbsupplier WHERE city=
        (SELECT id FROM jbcity WHERE name='Los Angeles'));

DELETE FROM jbsupplier
WHERE city=
    (SELECT id FROM jbcity WHERE name='Los Angeles');

/*
mysql> DELETE FROM jbsale
    -> WHERE item IN 
    ->     (SELECT id FROM jbitem WHERE supplier IN
    ->         (SELECT id from jbsupplier WHERE city=
    ->             (SELECT id FROM jbcity WHERE name='Los Angeles')));
Query OK, 1 row affected (0.01 sec)

mysql> DELETE FROM jbitem
    -> WHERE supplier IN
    ->     (SELECT id from jbsupplier WHERE city=
    ->         (SELECT id FROM jbcity WHERE name='Los Angeles'));
Query OK, 2 rows affected (0.01 sec)

mysql> DELETE FROM custom_item 
    -> WHERE supplier IN
    ->     (SELECT id from jbsupplier WHERE city=
    ->         (SELECT id FROM jbcity WHERE name='Los Angeles'));
Query OK, 1 row affected (0.01 sec)

mysql> DELETE FROM jbsupplier
    -> WHERE city=
    ->     (SELECT id FROM jbcity WHERE name='Los Angeles');
Query OK, 1 row affected (0.00 sec)

*/

/*
    b) Explain what you did and why
*/

/*
So, in order to delete the suppliers linked to “Los Angeles”, one first has to remove the rows in tables that have set jbsupplier as a FK/PK. 
The order we chose to delete in is the following:

1. Sales which include items delivered by said suppliers

2. Both jbitem and custom_item(prev exercise) where the supplier equals a supplier that originates from “Los Angeles”
This table references sales, so sales are deleted before this.

3. The actual suppliers from jbsupplier where the city code matches “Los Angeles” city code.
This table references items, so the affected rows have to be deleted after item.

*/



/*
Question 20: <Very long question with wierd formating. Wont post it here>
*/

SELECT
    jbsupplier.name as supplier_name,
    jbitem.name as item_name,
    IFNULL(jbsale.quantity, 0) as quantity
FROM jbsupplier
    INNER JOIN jbitem
        ON jbsupplier.id = jbitem.supplier
    LEFT OUTER JOIN jbsale
        ON jbitem.id = jbsale.item
ORDER BY jbsupplier.name;

/*
+---------------+-----------------+----------+
| supplier_name | item_name       | quantity |
+---------------+-----------------+----------+
| Cannon        | Wash Cloth      |        0 |
| Cannon        | Towels, Bath    |        5 |
| Cannon        | Twin Sheet      |        1 |
| Cannon        | Queen Sheet     |        0 |
| Fisher-Price  | Maze            |        0 |
| Fisher-Price  | The 'Feel' Book |        0 |
| Fisher-Price  | Squeeze Ball    |        0 |
| Levi-Strauss  | Shirt           |        1 |
| Levi-Strauss  | Bellbottoms     |        0 |
| Levi-Strauss  | Jean            |        0 |
| Levi-Strauss  | Boy's Jean Suit |        0 |
| Playskool     | ABC Blocks      |        0 |
| Playskool     | Clock Book      |        2 |
| White Stag    | Jacket          |        1 |
| White Stag    | Ski Jumpsuit    |        3 |
| White Stag    | Slacks          |        0 |
| Whitman's     | 2 lb Box, Mix   |        0 |
| Whitman's     | 1 lb Box        |        2 |
+---------------+-----------------+----------+
18 rows in set (0.00 sec)

*/