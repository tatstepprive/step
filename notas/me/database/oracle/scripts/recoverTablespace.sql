create tablespace noncrit datafile '/u01/app/oracle/oradata/ORCL/nocrit.dbf' size 2m;
--ORA-02199: missing DATAFILE/TEMPFILE clause
/* Oracle managed files (OMF)
datafile is optional
when datafile is included, file name is optional
if both not provided: check parameter db_create_file_dest, set if his value is empty
*/

-- see file creation 
select dbms_metadata.get_ddl('TABLESPACE','NONCRIT') from dual;

--check
select * from dba_tablespaces;
select * from v$tablespace;
select * from dba_data_files;

create table my_date (my_date date) tablespace noncrit;

insert into my_date values(sysdate);commit;

create table birthday (birthday date);

insert into birthday values (sysdate);
commit;
select * from birthday;

--using rman backup tablespace
--rman>backup as compressed backupset tablespace nocrit;
--on fs corrupt datafile header=remove first lines in /u01/app/oracle/oradata/ORCL/nocrit.dbf

--flush buffer_cache, so next read will be from disk
alter system flush buffer_cache;

--flush did not helped, so try to stop db and it will give error (db can not be stopped)
shutdown immediate;
--output
--ORA-01122: database file 36 failed verification check
--ORA-01110: data file 36: '/u01/app/oracle/oradata/ORCL/nocrit.dbf
--ORA-01210: data file header is media corrupt

--read data from disk on corrupted datafile
select * from my_date;
--output ORA-01578, ORA-01110

--rman recover
--rman target /
--RMAN> list backup of tablespace noncrit;
--RMAN> list failure;
--RMAN> advise failure;
--RMAN> repair failure;

shutdown immediate;
--OK
startup;
--OK

select * from my_date;
--output OK, noncrit is good recovered

select * from birthday;
--output OK, the table is still there after recover noncrit tablespace

