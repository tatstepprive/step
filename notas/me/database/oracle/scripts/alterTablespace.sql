--RENAME 
--rename tablespace
alter tablespace ts1 rename to ts2;
--rename datafile online (zero down time)
--alter database move datafile 'path' to 'newpath';
-- the new path should exist. First create directory /u01/app/oracle/oradata/ORCL/pdb1/data/ 
alter database move datafile '/u01/app/oracle/oradata/ORCL/pdb1/ts1_02.dbf' to '/u01/app/oracle/oradata/ORCL/pdb1/data/ts1_002.dbf';
--Queries and dml, ddl operations can be performed when renaming/moving datafiles in tablespace
-- if REUSE option is done, the existing file will be overwritten if it's exists
-- if KEEP option is done (not allowed for oracle managed files OMF), the old file will be kept
-----------------------------------------------
--READ ONLY
--tablespace read write or read only (ro= no DML, but drop can)
-- set tablespace read only
alter tablespace ts1 read only;

select * from dba_users where default_tablespace='TS1';

select * from dba_objects where owner='MOLLY';

desc molly.city;

select * from molly.city;

insert into molly.city values (1,'brussels');
--will give errors
-- ORA-01647: tablespace 'TS1' is read-only, cannot allocate space in it
-- ORA-01110: data file: '/u01/app/oracle/oradata/ORCL/pdb1/xxx/xxx.dbf'

--set tablespace read write
alter tablespace ts1 read write;
------------------------------------------------
--ONLINE OFFLINE
-- if tbs is offline - can not be used
alter tablespace ts1 offline;
alter tablespace ts1 online;
------------------------------------------------
--RESIZE
-- Resize tablespace methode1: resize file (now 100MB, set 200MB) (if tablespace ts1 consist from 1 file)
-- show size before
select dbms_metadata.get_ddl('TABLESPACE', 'TS1') from dual;
-- resize (to bigger value)
alter database datafile '/u01/app/oracle/oradata/ORCL/pdb1/xxx/xxx.dbf' resize  200M;
-- show size after
select dbms_metadata.get_ddl('TABLESPACE', 'TS1') from dual;
-- Resize tablespace methode2: add extra file to tablespace ts1 -> tablespace size is sum of all files in this tablespace
-- alter tablespace ts1 add datafile 'path' size nK|M|G;
alter tablespace ts1 
add datafile '/u01/app/oracle/oradata/ORCL/pdb1/ts1_02.dbf' size 10M;
--check new file added
select * from v$datafile;
--------------------------------------------------

