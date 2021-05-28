select dbms_metadata.get_ddl('TABLESPACE','TS2') from dual;

create user nancy identified by nancy123 default tablespace ts2;

create table nancy.country(id number, name varchar2(100));

--show tablespace where table is created
select * from dba_tables where table_name='COUNTRY';
select * from dba_users where username='NANCY';

--drop tablespace (tables will be dropped too, but users will exist)
drop tablespace ts2 including contents and datafiles;

--check
select * from dba_tables where table_name='COUNTRY';
--gone
select * from dba_users where username='NANCY';
--still exist with default_tablespace=TS2
