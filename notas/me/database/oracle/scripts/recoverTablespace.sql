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

--using rman backup tablespace
--rman>backup as compressed backupset tablespace nocrit;
--on fs corrupt datafile header=remove first lines in /u01/app/oracle/oradata/ORCL/nocrit.dbf

--flush buffer_cache, so next read will be from disk
alter system flush buffer_cache;

--read data from disk on corrupted datafile
select * from my_date;
--output ORA-01578, ORA-01110

--rman recover

