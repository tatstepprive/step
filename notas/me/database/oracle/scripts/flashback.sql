--Flashback works without FRA (flash recovery area) dont confuse them.
--Flashback query
select count(*) from molly.city;
--1,002,002 rows

delete from molly.city;
--1,002,002 rows deleted.

select count(*) from molly.city;
--0 rows

insert into molly.city (select * from molly.city as of timestamp(sysdate -5/1440));

select count(*) from molly.city;
--1,002,002 rows

select * from molly.city
---------------------------
--Flashback drop
drop table molly.city; 

select count(*) from molly.city; 
--error table does not exit
flashback table molly.city to before drop;

select count(*) from molly.city;
--1,002,002 rows
