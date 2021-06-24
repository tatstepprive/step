-- Create a test table with different contraint types on column level
-- syntax after column: 
-- [constraint <constraint_name>] <constraint_type>
create table test1 (
id number           constraint test1_pk primary key, --can not be null
name varchar2(100) constraint test1_fname_uk unique, --can be null
age number not null, --constraint name will be SYS Cn where n number -- can not be null
number_children number constraint test1_age_nn not null, --can not be null
gender char(1) constraint test1_gender_chq check (gender in ('M','F')), --can be null
nationality_id number constraint test1_natinality_fk references nationalities (id) --can be null
);

-- Create a test table with different contraint types on column level
-- syntax after column: 
-- [constraint <constraint_name>] <constraint_type>
create table test10 (
id number primary key,  -- can not be null --constraint name will be SYS Cn where n number
name varchar2(100) unique, --can be null  --constraint name will be SYS Cn where n number
age number not null, --constraint name will be SYS Cn where n number
number_children number not null, --can not be null  --constraint name will be SYS Cn where n number
gender char(1) check (gender in ('M','F')), --can be null  --constraint name will be SYS Cn where n number
nationality number references nationalities (id) --can be null  --constraint name will be SYS Cn where n number
);

-- Create a test table with different contraint types on table level (recommended)
-- force to put name constraint, pk can be defined of multiple column
-- syntax at the and of table definition:
-- constraint <constraint_name> <constraint_type> (<column_of_this_table>)
-- not null constraint can not be at table level, only at column level
create table test2 (
id number,
name varchar2(100),
age number not null, --constraint name will be SYS Cn where n number --can not be null
number_children number constraint test2_age_nn not null, --can not be null
gender char(1),
nationality_id number,
constraint test2_pk primary key (id), --can not be null
constraint test2_fname_uk unique (name), --can be null
constraint test2_gender_chq check (gender in ('M','F')), --can be null
constraint test2_natinality_fk FOREIGN KEY (nationality_id) references nationalities (id) --can be null
);

-- Create a test table with a primary key constraint
create table test3 (
  col1  number(10) not null,
  col2  varchar2(50) not null);

alter table test3 add (
  constraint test3_pk primary key (col1));


-- Describe the table
desc test3
-- Output
-- Name                 Null?    Type
 -------------------- -------- --------------------
-- COL1                 NOT NULL NUMBER(10)
-- COL2                 NOT NULL VARCHAR2(50)

-- Display the constraint name.
select constraint_name
from   user_constraints
where  table_name      = 'TEST3'
and    constraint_type = 'P';
--Output
--CONSTRAINT_NAME
------------------------------
--TEST3_PK
--1 row selected.



-- Display the index name.
select index_name, column_name
from   user_ind_columns
where  table_name = 'TEST3';

--output
--INDEX_NAME            COLUMN_NAME
--------------------  --------------------
--TEST3_PK              COL1
--1 row selected.

-- Rename the table, columns, primary key and supporting index.
alter table test3 rename to test;

alter table test rename column col1 to id;

alter table test rename column col2 to description;

alter table test rename constraint test3_pk to test_pk;

alter index test3_pk rename to test_pk;


-- Describe the table.
desc test
-- Output
-- Name                 Null?    Type
 -------------------- -------- --------------------
-- ID                   NOT NULL NUMBER(10)
-- DESCRIPTION          NOT NULL VARCHAR2(50)

-- Display the constraint name.
select constraint_name
from   user_constraints
where  table_name      = 'TEST'
and    constraint_type = 'P';
--Output
--CONSTRAINT_NAME
--------------------
--TEST_PK
--1 row selected.

-- Display the index name.
select index_name, column_name
from   user_ind_columns
where  table_name = 'TEST';
--Output
--INDEX_NAME            COLUMN_NAME
--------------------  --------------------
--TEST_PK               ID
--1 row selected.

