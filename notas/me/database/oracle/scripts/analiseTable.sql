--see also analyseConstraints.sql
--create table simple
create table test5 (id number);
insert into table values (10);

--create table using subquery (only not null constraints are respected, other are not copied, no fk and pk constriants)
create table copy_emp AS select * from emp;

--create table using subquery with conditions (only not null constraints are respected, other are not copied, no fk and pk constriants)
create table copy_emp AS select id, fname, lname from emp where id >200;

--create table using subquery with conditions and other columnames (only not null constraints are respected, other are not copied, no fk and pk constriants)
create table copy_emp (emp_id, first_name, last_name) AS select id, fname, lname from emp where id >200;

--create emty table like other table (using invalid condition 1=2 is never true)
select table copy_emp AS select * from emp where 1=2;

--shrink table (not work for tables containing lobs)
select * from dba_segments where tablespace_name like 'USE%';
alter table hr.sales enable row movement;
alter table hr.sales shrink space;
