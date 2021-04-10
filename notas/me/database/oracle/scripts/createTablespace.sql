create tablespace ts1;
--ORA-02199: missing DATAFILE/TEMPFILE clause
/* Oracle managed files
datafile is optional
when datafile is included, file name is optional
if both not provided: check parameter db_create_file_dest, set if his value is empty
*/

show parameter db_create_file_dest;
show con_name;
--if value is empty set
alter system set db_create_file_dest='/u01/app/oracle/oradata/ORCL/pdb1';

--create tablespace, default will be added automatically
create tablespace ts1;
--OK
-- see file creation in /u01/app/oracle/oradata/ORCL/pdb1/ORCL/xxx/datafile/xxx.dbf
select dbms_metadata.get_ddl('TABLESPACE','TS1') from dual;

--check
select * from dba_tablespaces;
select * from v$tablespace;
select * from dba_data_files;

create user molly identified by molly123 default tablespace ts1;

select dbms_metadata.get_ddl('USER', 'MOLLY') from dual;

create table molly.city(id number, name varchar2(100));

--show tablespace where table is created
select * from dba_tables where table_name='CITY';


