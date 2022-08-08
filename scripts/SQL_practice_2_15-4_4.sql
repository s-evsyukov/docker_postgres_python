
--#  #  #  #  #   #  #  #  #  #   #  #  #  #  #   #  #  #  #  #   #  #  #  #  #
--2.15 LIKE
SELECT last_name, first_name
FROM employees e
WHERE first_name LIKE '%n';


SELECT last_name, first_name
FROM employees e
WHERE last_name LIKE 'B%';

SELECT last_name, first_name
FROM employees e
WHERE last_name LIKE '_uch%';

--2.16 LIMIT
SELECT product_name, unit_price
FROM products p
LIMIT 10;

-- 2.17 Check on NULL
SELECT ship_city, ship_region, ship_country
FROM orders o
WHERE ship_region IS NOT NULL;

SELECT ship_city, ship_region, ship_country
FROM orders o
WHERE ship_region ISNULL;

--2.18 GROUP BY
SELECT ship_country, count(*)
FROM orders o
WHERE freight > 50
GROUP BY ship_country
ORDER BY count(*) DESC;

SELECT category_id, sum(units_in_stock)
FROM products p
GROUP BY category_id
ORDER BY sum(units_in_stock) DESC
LIMIT 5;

--2.19 HAVING (postfilter) work as WHERE
SELECT category_id AS i, sum(unit_price * units_in_stock) AS foo
FROM products p
WHERE discontinued <> 1
GROUP BY category_id
HAVING sum(unit_price * units_in_stock) > 5000
ORDER BY sum(unit_price * units_in_stock) DESC;

--2.20 UNION (операции на множествах)

SELECT country
FROM customers c
UNION
SELECT country
FROM employees e;

SELECT country
FROM customers c
UNION all
SELECT country
FROM employees e;

--INTERSECT (selects if bouth came from country)
SELECT country
FROM customers c
INTERSECT
SELECT country
FROM suppliers s;

--EXCEPT (if if bouth not came from country)
SELECT country
FROM customers c
EXCEPT
SELECT country
FROM suppliers s;

SELECT country
FROM customers c
EXCEPT all
SELECT country
FROM suppliers s;

--#  #  #  #  #   #  #  #  #  #   #  #  #  #  #   #  #  #  #  #   #  #  #  #  #
--2.21-EXAM
--  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
--1. Выбрать все записи заказов в которых наименование страны отгрузки начинается с 'U'
SELECT *
FROM orders
WHERE ship_country LIKE 'U%'
ORDER BY ship_city;

--2. Выбрать записи заказов (включить колонки идентификатора заказа, идентификатора заказчика,
--веса и страны отгузки), которые должны быть отгружены в страны имя которых начинается с 'N',
--отсортировать по весу (по убыванию) и вывести только первые 10 записей.
SELECT order_id, customer_id, freight, ship_country
FROM orders o
WHERE ship_country LIKE 'N%'
ORDER BY freight DESC
LIMIT 10;

--3. Выбрать записи работников (включить колонки имени, фамилии, телефона, региона) в которых регион неизвестен
SELECT first_name, last_name, home_phone, region
FROM employees e
WHERE region ISNULL;

--4. Подсчитать кол-во заказчиков регион которых известен
SELECT count(customer_id)
FROM customers c
WHERE region IS NOT NULL;

--5. Подсчитать кол-во поставщиков в каждой из стран и отсортировать результаты группировки по убыванию кол-ва
SELECT country, count(*)
FROM suppliers s
GROUP BY country
ORDER BY count(*) DESC;

--6. Подсчитать суммарный вес заказов (в которых известен регион) по странам, затем отфильтровать
--по суммарному весу (вывести только те записи где суммарный вес больше 2750) и отсортировать по убыванию суммарного веса.
SELECT ship_country, sum(freight)
FROM orders o
WHERE ship_region IS NOT NULL
GROUP BY ship_country
HAVING sum(freight) > 2750
ORDER BY sum(freight) DESC;

--7. Выбрать все уникальные страны заказчиков и поставщиков и отсортировать страны по возрастанию
SELECT DISTINCT country, company_name
FROM suppliers s
ORDER BY country;

--8. Выбрать такие страны в которых "зарегистированы" одновременно и заказчики и поставщики и работники.
SELECT country
FROM customers c
UNION
SELECT country
FROM employees e
UNION
SELECT country
FROM suppliers s;

--9. Выбрать такие страны в которых "зарегистированы" одновременно заказчики и поставщики,
--но при этом в них не "зарегистрированы" работники.
SELECT country
FROM customers c
UNION
SELECT country
FROM suppliers s
EXCEPT
SELECT country
FROM employees e;


--  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
--3.1 Знакомство с соединениями
--3.2 INNER JOIN
SELECT product_name, suppliers.company_name, units_in_stock
FROM products
INNER JOIN suppliers ON products.supplier_id = suppliers.supplier_id
ORDER BY units_in_stock DESC;

-- Сколько единиц товара в продаже по категориям товаров
--
SELECT category_name, sum(units_in_stock)
FROM products
INNER JOIN categories ON products.category_id = categories.category_id
GROUP BY category_name
ORDER BY sum(units_in_stock) DESC
LIMIT 5;

-- Сколько единиц товара в продаже по категориям товаров в денежном эквиваленте
-- показать те что дороже 5000
SELECT category_name, sum(unit_price * units_in_stock)
FROM products
INNER JOIN categories ON products.category_id = categories.category_id
WHERE discontinued  <> 1
GROUP BY category_name
HAVING sum(unit_price * units_in_stock) > 5000
ORDER BY sum(unit_price * units_in_stock) desc
LIMIT 6;

-- на каких работниках завязаны заказы
SELECT order_id, customer_id, last_name, first_name, title
FROM orders
INNER JOIN employees ON employees.employee_id = orders.employee_id;

SELECT order_id, customer_id, last_name, first_name, title
FROM orders
INNER JOIN employees ON employees.employee_id = orders.employee_id
ORDER BY order_id DESC;

-- множественное сединение
SELECT order_date, product_name, ship_country, products.unit_price, quantity, discount
FROM orders
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON products.product_id = order_details.product_id
LIMIT 5;

SELECT contact_name, company_name, phone, first_name, last_name, title,
order_date, product_name, ship_country, products.unit_price, quantity, discount
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
JOIN customers ON orders.customer_id  = customers.customer_id
JOIN employees ON employees.employee_id = orders.employee_id
WHERE ship_country = 'USA'
LIMIT 5;

--3.3 LEFT Join
SELECT company_name, product_name
FROM suppliers
JOIN products ON suppliers.supplier_id = products.supplier_id;

SELECT company_name, product_name
FROM suppliers
LEFT JOIN products ON suppliers.supplier_id = products.supplier_id;

SELECT company_name, order_id
FROM customers
LEFT JOIN orders ON orders.customer_id  = customers.customer_id
WHERE order_id IS NULL;

SELECT count(*)
FROM employees
LEFT JOIN orders ON orders.employee_id = employees.employee_id
WHERE order_id IS NULL;

-- RIGHT JOIN
SELECT company_name, order_id
FROM orders
RIGHT JOIN customers ON orders.customer_id  = customers.customer_id
WHERE order_id IS NULL;

--3.4 SELF JOIN

-- у каждого работника есть менеджер, manager_id - указывает кто менеджер этого работника
CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR (255) NOT NULL,
    last_name VARCHAR (255) NOT NULL,
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES employee (employee_id)
);

INSERT INTO employee VALUES (1, 'Windy', 'Mays', NULL);
INSERT INTO employee VALUES (2, 'Ava', 'Christensen', 1);
INSERT INTO employee VALUES (3, 'Kassan', 'Conner', 1);
INSERT INTO employee VALUES (4, 'Anna', 'Reeves', 2);
INSERT INTO employee VALUES (5, 'Sau', 'Norman', 2);
INSERT INTO employee VALUES (6, 'Kelsea', 'Hays', 3);
INSERT INTO employee VALUES (7, 'Tory', 'Goff', 3);
INSERT INTO employee VALUES (8, 'Salley', 'Lester', 3);

SELECT e.first_name || ' ' || e.last_name AS employee,
    m.first_name || ' ' || m.last_name AS manager
FROM employee e
LEFT JOIN employee m ON m.employee_id = e.employee_id
ORDER BY manager

-- 3.5 USING
-- в место этого кода:
SELECT contact_name, company_name, phone, first_name, last_name, title,
order_date, product_name, ship_country, products.unit_price, quantity, discount
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
JOIN customers ON orders.customer_id  = customers.customer_id
JOIN employees ON employees.employee_id = orders.employee_id
WHERE ship_country = 'USA'
LIMIT 5;
-- пишем этот:
SELECT contact_name, company_name, phone, first_name, last_name, title,
order_date, product_name, ship_country, products.unit_price, quantity, discount
FROM orders
JOIN order_details USING(order_id)
JOIN products USING(product_id)
JOIN customers USING(customer_id)
JOIN employees USING(employee_id)
WHERE ship_country = 'USA'
LIMIT 5;

-- NATURAL JOIN
-- (работает как INNER JOIN по столбцам с одинаковым наименованием)
SELECT order_id, customer_id, first_name, last_name, title
FROM orders
NATURAL JOIN employees;

--3.6 AS -псевдоним -не работает в WHERE
SELECT count(*) AS empl_count
FROM employees;

SELECT count(DISTINCT country) AS count_country
FROM customers;

SELECT category_id, sum(units_in_stock) AS un_in_stock
FROM products
GROUP BY category_id
ORDER BY un_in_stock DESC
LIMIT 5;

--
SELECT category_id, sum(unit_price * units_in_stock) AS total_price
FROM products
WHERE discontinued <> 1
GROUP BY category_id
ORDER BY total_price
HAVING sum(unit_price * units_in_stock) > 5000;

--  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
-- Quiz 3.7
--  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
-- 1. Найти заказчиков и обслуживающих их заказы сотрудников таких,
-- что и заказчики и сотрудники из города London, а доставка идёт компанией Speedy Express.
-- Вывести компанию заказчика и ФИО сотрудника.

SELECT c.company_name, e.last_name || ' ' || e.first_name
FROM orders AS o
LEFT JOIN employees AS e USING(employee_id)
LEFT JOIN customers AS c USING(customer_id)
LEFT JOIN shippers AS s ON o.ship_via = s.shipper_id
WHERE e.city = 'London'
AND c.city = 'London'
AND s.company_name = 'Speedy Express';

-- 2. Найти активные (см. поле discontinued) продукты из категории Beverages и Seafood,
-- которых в продаже менее 20 единиц. Вывести наименование продуктов, кол-во единиц в продаже,
-- имя контакта поставщика и его телефонный номер.

SELECT p.product_name, p.units_in_stock, s.contact_name, s.phone
FROM products AS p
LEFT JOIN categories AS c USING(category_id)
LEFT JOIN suppliers AS s USING(supplier_id)
WHERE discontinued = 0 AND category_name in('Beverages', 'Seafood') AND p.units_in_stock < 20
ORDER BY units_in_stock;

-- 3. Найти заказчиков, не сделавших ни одного заказа. Вывести имя заказчика и order_id.

SELECT c.contact_name, o.order_id
FROM customers AS c
LEFT JOIN orders AS o USING(customer_id)
WHERE order_id IS NULL

-- 4. Переписать предыдущий запрос, использовав симметричный вид джойна (подсказка: речь о LEFT и RIGHT).
SELECT c.contact_name, o.order_id
FROM orders AS o
right JOIN customers AS c USING(customer_id)
WHERE order_id IS NULL
--  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -


--  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
-- 4.1 Подзапрос
--  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
-- Найти все компании поставщиков из тех стран, в которых находятся сами заказчики
SELECT company_name
FROM suppliers AS s
WHERE country IN (SELECT DISTINCT country
				  FROM customers
				 );

SELECT s.company_name
FROM suppliers AS s
JOIN customers using(country);

-- Вывести сумму единиц товара и лимитировать резултирующий набор числом,
-- которое необходимо вычислить( найменьший product_id + 4)

SELECT c.category_name, sum(p.units_in_stock)
FROM products AS p
JOIN categories AS c USING(category_id)
GROUP BY c.category_name
ORDER BY sum(p.units_in_stock)
LIMIT (SELECT MIN(product_id) + 4 FROM products);

-- Вывести такие товары, колличество которых в наличии больше чем в среднем
SELECT p.product_name, p.units_in_stock
FROM products AS p
WHERE units_in_stock > (SELECT avg(units_in_stock) FROM products)
ORDER BY units_in_stock;


-- 4.2 Where EXISTS
-- - return True if subquery return any data or False nan

-- select companys with orders freight is more then 50 and less then 100
SELECT company_name, contact_name
FROM customers c
WHERE EXISTS (SELECT customer_id FROM orders o
				WHERE customer_id = c.customer_id
				AND freight BETWEEN 50 AND 100);

SELECT company_name, contact_name
FROM customers c
WHERE NOT EXISTS (SELECT customer_id FROM orders o
				WHERE customer_id = c.customer_id
				AND order_date BETWEEN '1995-02-01' AND '1995-02-15');

SELECT product_name
FROM products p
WHERE NOT EXISTS (
	SELECT order_id FROM orders
	JOIN order_details  USING(order_id)
	WHERE order_details.product_id=product_id
	AND order_date BETWEEN '1995-02-01' AND '1995-02-15'
);

-- 4.3 Sub query with ANY, ALL

-- Select all unique (distinct) customers companys with orders with more than 40 units
SELECT DISTINCT c.company_name
FROM customers c
JOIN orders USING(customer_id)
JOIN order_details USING (order_id)
WHERE quantity > 40;

SELECT DISTINCT company_name
FROM customers
WHERE customer_id = ANY(
	SELECT customer_id
	FROM orders
	JOIN order_details USING (order_id)
WHERE quantity > 40
);

-- Select products with quantuty biger then avarage orders
SELECT avg(od.quantity)
FROM order_details od

SELECT DISTINCT p.product_name, od.quantity
FROM order_details od
LEFT JOIN products p using(product_id)
WHERE quantity > ANY(
	SELECT avg(quantity)
	FROM order_details
)
ORDER BY quantity;

-- Select all products with quantity biger then avarage quantity of orders from groups made from product_id
SELECT AVG(quantity)
FROM order_details
GROUP BY product_id;

SELECT DISTINCT p.product_name, od.quantity
FROM products p
LEFT JOIN order_details od using(product_id)
WHERE quantity > all(
	SELECT AVG(quantity)
	FROM order_details
	GROUP BY product_id
)
ORDER BY quantity;

--  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
-- 4.4 Quiz
--  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
-- 1. Вывести продукты количество которых,
-- в продаже меньше самого малого среднего количества продуктов в деталях заказов (группировка по product_id).
-- Результирующая таблица должна иметь колонки product_name и units_in_stock.
SELECT p.product_name, p.units_in_stock
FROM products p
WHERE units_in_stock < all(
	SELECT AVG(quantity)
	FROM order_details
	GROUP BY product_id
)
ORDER BY units_in_stock desc;


-- 2. Напишите запрос, который выводит общую сумму фрахтов заказов для компаний-заказчиков для заказов,
-- стоимость фрахта которых больше или равна средней величине стоимости фрахта всех заказов,
-- а также дата отгрузки заказа должна находится во второй половине июля 1996 года.
-- Результирующая таблица должна иметь колонки customer_id и freight_sum,
-- строки которой должны быть отсортированы по сумме фрахтов заказов.

SELECT customer_id, sum(freight) AS freight_sum
FROM orders
INNER JOIN (SELECT customer_id, AVG(freight) AS freight_avg
			FROM orders
			GROUP BY customer_id) AS foo
USING(customer_id)
WHERE freight > freight_avg AND shipped_date BETWEEN '1996-07-16' AND '1996-07-31'
GROUP BY customer_id
ORDER BY freight_sum;

-- 3. Напишите запрос, который
-- выводит 3 заказа с наибольшей стоимостью, которые
-- были созданы после 1 сентября 1997 года включительно и были доставлены в страны Южной Америки.
-- Общая стоимость рассчитывается как сумма стоимости деталей заказа с учетом дисконта.
-- Результирующая таблица должна иметь колонки customer_id, ship_country и order_price,
-- строки которой должны быть отсортированы по стоимости заказа в обратном порядке.
SELECT o.customer_id, o.ship_country, order_price
FROM orders o
JOIN (SELECT od.order_id, sum(od.unit_price * od.quantity - od.unit_price * od.quantity * od.discount) AS order_price
	  FROM order_details od
	  GROUP BY od.order_id) AS op
USING (order_id)
WHERE ship_country IN ('Argentina', 'Bolivia', 'Brazil', 'Chile', 'Columbia',
               'Ecuador', 'Guyana', 'Paraguay', 'Peru', 'Suriname', 'Uruguay', 'Venezuela')
AND order_date >= '1997-09-01'
ORDER BY order_price DESC
LIMIT 3;

-- 4. Вывести все товары (уникальные названия продуктов), которых заказано ровно 10
-- единиц (конечно же, это можно решить и без подзапроса).

SELECT DISTINCT product_name
FROM products
WHERE product_id = ANY(
	SELECT product_id
	FROM order_details
	WHERE quantity = 10
);

SELECT DISTINCT product_name, quantity
FROM products
LEFT JOIN order_details using(product_id)
WHERE quantity = 10;
--  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -