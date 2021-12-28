--sqlplus / as sysdba;
--show con_name;
--alter session set container=orclpdb;
--show con_name;
create user dropper identified by dropper;
grant create session, resource, unlimited tablespace to dropper;
--connect dropper@orclpdb;
create table names (name varchar2(10));
create index name_idx on names(name);
alter table names add (constraint name_u unique(name));
insert into names values('John');
commit;
select object_name, object_type from user_objects;
--in sqlplus when connecting as dropper to orclpdb;
select * from user_objects;
select * from user_constraints;
drop table names;
select * from user_recyclebin;
-- show recyclebin;
--connect as sys or system
select * from dba_recyclebin where owner='DROPPER';
--as dropper
--select dropped table using recycle bin name between double quotes 
--select OK, no DML (insert, update) are permitted
select * from "BIN$1DUyrysRYengUzUBqMDWeg==$0";
--table and index are gone
select * from user_objects;
-- constraint is not gone, but changed name in BINxxx
select * from user_constraints;
--bring back table  (use table name or bin name)
flashback table names to before drop;

--table and index are back, but index is still with name BINxxx, rename it
alter index "BIN$1DUyrysQYengUzUBqMDWeg==$0" rename to name_idx;
--rename constraint
alter table names rename constraint "BIN$1DUyrysPYengUzUBqMDWeg==$0" to name_u;
--Attention no flashback drop possible if the next executed:
-- recyclebin parameter is off
-- drop table t1 purge;
-- drop user u1 cascade;
-- purge recyclebin;
