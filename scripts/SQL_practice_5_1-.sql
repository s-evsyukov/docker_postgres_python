-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- DDL Data defenition language
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- 5.1

CREATE TABLE table_name

-- change table
ALTER TABLE table_name

	ADD COLUMN column_name data_type

	RENAME TO new_table_name

	RENAME old_column_nmae TO new_column_name

	ALTER COLUMN column_name SET DATA TYPE data_type

-- delete table
DROP TABLE table_name;

-- cleare data from table
TRUNCATE TABLE table_name;

-- delete column
DROP COLUMN column_name;


-- practice --

CREATE TABLE student
(
	student_id serial,
	first_name varchar,
	last_name varchar,
	birthday date,
	phone varchar
);

CREATE TABLE cathedra
(
	cathedra_id serial,
	cathedra_name varchar,
	dekan varchar
);

-- add column to table
ALTER TABLE student
ADD COLUMN mile_name varchar;

ALTER TABLE student
ADD COLUMN raiting float;

ALTER TABLE student
ADD COLUMN enrolled date;

-- delete column from table
ALTER TABLE student
DROP COLUMN mile_name;

-- rename table
ALTER TABLE cathedra
RENAME TO chair;

-- rename column
ALTER TABLE chair
RENAME cathedra_id TO chair_id;

ALTER TABLE chair
RENAME cathedra_name TO chair_name;

-- change column data type
ALTER TABLE student
ALTER COLUMN first_name SET DATA TYPE varchar(64);

ALTER TABLE student
ALTER COLUMN phone SET DATA TYPE varchar(32);











