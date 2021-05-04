--Flashback query
delete from cities;
--2 rows deleted
commit;
select count(*) from cities;
--output 0
insert into cities (select * from cities as of timestamp(sysdate -5/1440));
-- 5/1440=5minutes
commit;
select count(*) from cities;
--ouput 2 rows
---------------------------
--Flashback drop
drop table cities;
select count(*) from cities;
--error
flashback table cities to before drop;
select count(*) from cities;
--2 rows
