
-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
-- SQL - Structured query language
-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

--типы SQL языков

--DDL - Data Defination Language 			(CREATE, ALTER, DROP)

--DML - Data Manipulation Language 			(SELECT, INSERT, UPDATE, DELETE)

--TCL - Transaction Controll Language 		(COMMIT, ROLLBAACK, SAVEPOINT)

--DCL - Data Contro; Language 				(GRANT, REVOKE, DENY)

--ANSI SQL-92

--Типы данны

--Integral
--	- smallint
--	- int
--	- bigint
--Real
--	- decimal / numeric
--	- real / float4
--	- float8
--characters
--	- char (fixed, maximized)
--	- varchar (fixed, not maximized)
--	- text (not fixed)
--logical
--	- boolean / bool
--temporal
--	- date
--	- time
--	- timestamp
--	- interval
--	- timestampptz
--arrays

--JSON

--XML

--geometric

--custom

--NULL


--one to many

--fk_id roreign key

--###################################################################
--One TO many

CREATE TABLE books
(
	books_id int PRIMARY KEY,
	title text NOT NULL,
	isbn varchar(32) NOT NULL,
	fk_publisher_id int REFERENCES publisher(publisher_id) NOT NULL
);

CREATE TABLE publisher
(
	publisher_id int PRIMARY KEY,
	name varchar(128) NOT NULL,
	adress varchar(128) NOT NULL
);

INSERT INTO books
VALUES
(1, 'The Diary', '1298736491273', 1),
(2, 'Pride something', '1234523666789', 1),
(3, 'To kil lorem', '003453964354', 2),
(4, 'The book ipsum', '345345345491273', 2),
(5, 'War name', '1234523664345634', 2);

INSERT INTO publisher
VALUES
(1, 'Everman''s lib', 'NY'),
(2, 'Oxford lib', 'NY'),
(3, 'Grand lib', 'Washington'),
(4, 'Simon lib', 'Chicago');

SELECT * FROM books;
SELECT * FROM publisher p;


ALTER TABLE books
ADD COLUMN fk_publisher_id int;

ALTER TABLE books
ADD CONSTRAINT fk_publisher_id  FOREIGN KEY(fk_publisher_id)
REFERENCES publisher(publisher_id);

DROP TABLE books;

--#  #  #  #  #   #  #  #  #  #   #  #  #  #  #   #  #  #  #  #   #  #  #  #  #
--One TO one

CREATE TABLE person
(
	person_id int PRIMARY KEY,
	first_name varchar(64) NOT NULL,
	last_name varchar(64) NOT NULL
);

CREATE TABLE passport
(
	passport_id int PRIMARY KEY,
	serial_number int NOT NULL,
	adress varchar(32) NOT NULL,
	fk_passport_person int UNIQUE REFERENCES person(person_id)
);

DROP TABLE IF EXISTS publisher ;

INSERT INTO person
VALUES
(1,'John', 'Snow'),
(2, 'Ned','Stark'),
(3, 'Rob', 'Baratheon');

INSERT INTO passport values
(1, 213214, 'Winterfell', 1),
(2, 243325, 'Winterfell', 2),
(3, 565464, 'King''s Landing', 3);

--#  #  #  #  #   #  #  #  #  #   #  #  #  #  #   #  #  #  #  #   #  #  #  #  #
--Many TO many

CREATE TABLE book
(
	book_id int PRIMARY KEY,
	title TEXT NOT NULL,
	isbn TEXT NOT NULL
);

CREATE TABLE author
(
	author_id int PRIMARY KEY,
	full_name text NOT NULL,
	rating REAL	NOT NULL
);


--primery KEY IS sum OF BOTH id!!!!

CREATE TABLE book_author
(
	book_id int REFERENCES book(book_id) NOT NULL,
	author_id int REFERENCES author(author_id) NOT NULL,
	CONSTRAINT book_author_pkey PRIMARY KEY (book_id, author_id) -- composite KEY !!!
);


INSERT INTO book
VALUES
(1, 'Book for Dumnies', '123456'),
(2, 'Book for Smart Guys', '7890123'),
(3, 'Book for Happy People', '4567890'),
(4, 'Book for Unhappy People', '1234567');

INSERT INTO author
VALUES
(1, 'Bob', 4.5),
(2, 'Alice', 4.0),
(3, 'John', 4.7);

INSERT INTO book_author
VALUES
(1, 1),
(2, 1),
(3, 1),
(3, 2),
(4, 1),
(4, 2),
(4, 3);

--#  #  #  #  #   #  #  #  #  #   #  #  #  #  #   #  #  #  #  #   #  #  #  #  #

--1. Выбрать все данные из таблицы customers
SELECT *
FROM customers;

--2. Выбрать все записи из таблицы customers,  но только колонки "имя контакта" и "город"
SELECT contact_name, city
FROM customers;

--3. Выбрать все записи из таблицы orders,  но взять две колонки: идентификатор заказа и колонку,
--значение в которой мы рассчитываем как разницу между датой отгрузки и датой формирования заказа.
SELECT order_id, shipped_date - order_date
FROM orders;

--4. Выбрать все уникальные города в которых "зарегестрированы" заказчики
SELECT DISTINCT city
FROM customers;

--5. Выбрать все уникальные сочетания городов и стран в которых "зарегестрированы" заказчики
SELECT DISTINCT city, country
FROM customers;

--6. Посчитать кол-во заказчиков
SELECT count(customer_id)
FROM customers;

--7. Посчитать кол-во уникальных стран в которых "зарегестрированы" заказчики
SELECT count(DISTINCT country)
FROM customers;

--2.4. Посчитать кол-во заказчиков
SELECT count(customer_id)
FROM customers;

--7. Посчитать кол-во уникальных стран в которых "зарегестрированы" заказчики
SELECT count(DISTINCT country)
FROM customers;
--#  #  #  #  #   #  #  #  #  #   #  #  #  #  #   #  #  #  #  #   #  #  #  #  #
--EXAM
--  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
--1. Выбрать все данные из таблицы customers
SELECT *
FROM customers;

--2. Выбрать все записи из таблицы customers, но только колонки "имя контакта" и "город"
SELECT contact_name, city
FROM customers;

--3. Выбрать все записи из таблицы orders, но взять две колонки: идентификатор заказа и колонку,
--значение в которой мы рассчитываем как разницу между датой отгрузки и датой формирования заказа.
SELECT order_id, shipped_date - order_date
FROM orders;

--4. Выбрать все уникальные города в которых "зарегестрированы" заказчики
SELECT DISTINCT city
FROM customers;

--5. Выбрать все уникальные сочетания городов и стран в которых "зарегестрированы" заказчики
SELECT DISTINCT city, country
FROM customers;

--#  #  #  #  #   #  #  #  #  #   #  #  #  #  #   #  #  #  #  #   #  #  #  #  #
--2.7. Выборка с фильтром
SELECT company_name, contact_name, phone
FROM customers
WHERE country = 'USA';

SELECT *
FROM products
WHERE unit_price > 20;

SELECT count(*)
FROM products
WHERE unit_price < 20;

SELECT *
FROM products
WHERE discontinued = 1;

SELECT *
FROM customers
WHERE city != 'Berlin';

SELECT *
FROM orders
WHERE order_date > '1998-03-01'
AND order_date < '1998-03-03';

--2.8. Фильтрация AND и OR
SELECT *
FROM products
WHERE unit_price > 25
AND units_in_stock > 40;

SELECT *
FROM customers
WHERE city = 'Berlin'
OR city = 'London'
OR city = 'San Francisco';

SELECT *
FROM orders
WHERE shipped_date > '1998-04-03'
AND (freight < 75 OR freight > 150);

-- 2.9.BETWEEN
SELECT *
FROM orders
WHERE freight >= 20 AND freight <= 40;

SELECT count(*)
FROM orders
WHERE freight BETWEEN 20 AND 40;

SELECT *
FROM orders
WHERE order_date BETWEEN '1998-03-30' AND '1998-04-03';

--2.10.IN
SELECT *
FROM customers
WHERE country IN ('Mexico', 'Germany', 'USA', 'Canada');

SELECT *
FROM products p
WHERE category_id IN (1,3,5,7);

-- & NOT IN
SELECT *
FROM customers c
WHERE country NOT IN ('Mexico', 'Germany', 'USA', 'Canada');

SELECT *
FROM products p
WHERE category_id NOT IN (1,3,5,7);

--2.11. ORDER BY
SELECT DISTINCT country
FROM customers
ORDER BY country ASC;

SELECT DISTINCT country
FROM customers
ORDER BY country DESC;

SELECT DISTINCT country, city
FROM customers c
ORDER BY country DESC, city ASC;

--2.12. MIN, MAX, AVG, SUM
SELECT ship_city, order_date
FROM orders
WHERE ship_city = 'London'
ORDER BY order_date;

SELECT MIN(order_date)
FROM orders
WHERE ship_city = 'London'

SELECT MAX(order_date)
FROM orders
WHERE ship_city = 'London'

SELECT AVG(unit_price)
FROM products p
WHERE discontinued <> 1;

SELECT SUM(units_in_stock)
FROM products p
WHERE discontinued <> 1;

--#  #  #  #  #   #  #  #  #  #   #  #  #  #  #   #  #  #  #  #   #  #  #  #  #
--2.13-EXAM
--  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
--Выбрать все заказы из стран France, Austria, Spain
SELECT *
FROM orders o
WHERE ship_country IN('France', 'Austria', 'Spain');

--Выбрать все заказы, отсортировать по required_date (по убыванию) и отсортировать по дате отгрузке (по возрастанию)
SELECT *
FROM orders o
ORDER BY required_date DESC,  shipped_date;

--Выбрать минимальную цену товара среди тех продуктов, которых в продаже более 30 единиц.
SELECT MIN(unit_price)
FROM products p
WHERE units_in_stock > 30;

--Выбрать максимальное кол-во единиц товара среди тех продуктов, стоимость которых более 30
SELECT MAX(product_id)
FROM products p
WHERE unit_price > 30;

SELECT MAX(units_in_stock)
FROM products p
WHERE unit_price > 30;

--Найти среднее значение дней уходящих на доставку с даты формирования заказа в USA
SELECT AVG(shipped_date - order_date)
FROM orders o
WHERE ship_country = 'USA';

--Найти сумму, на которую имеется товаров (кол-во * цену) причём таких,
--которые планируется продавать и в будущем (см. на поле discontinued)
SELECT SUM(product_id * unit_price)
FROM products p
WHERE discontinued <> 1;