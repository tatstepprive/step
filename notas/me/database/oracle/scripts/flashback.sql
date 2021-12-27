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
---------------------------
-- as HR user
select * from regions where region_id=1;
update regions set region_name='United Kingdom' where region_id=1;
commit;

--find xid
select region_name, versions_xid, versions_operation,versions_starttime,versions_endtime,versions_startscn,versions_endscn from regions
versions between scn minvalue and maxvalue 
where region_id=1;

--as SYS
alter session set container=orclpdb;

select region_name, versions_xid, versions_operation,versions_starttime,versions_endtime,versions_startscn,versions_endscn from HR.REGIONS
versions between scn minvalue and maxvalue 
where region_id=1;

--show undo query (if empty null, fix: ALTER DATABASE ADD SUPPLEMENTAL LOG DATA;)
select operation, undo_sql from flashback_transaction_query
where xid=hextoraw('05001200C0030000');

--revert committed transaction, commit is not incluced
begin
  dbms_flashback.transaction_backout(numtxns=>1,xids=>sys.xid_array('05001200C0030000'));
end;
/

commit;

select * from regions where region_id=1;
--output region_name Europa
----------------------------
