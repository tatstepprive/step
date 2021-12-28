--conn system@orclpdb;
create tablespace fda datafile 'fda1.dbf' size 10m;
--attention year not years
create flashback archive fla1 tablespace fda retention 5 year;
grant dba to fbdauser identified by fbdauser;
grant flashback archive on fla1 to fbdauser;
-- connect fbdauser@orclpdb;
create table t1 as select * from all_users;
alter table t1 flashback archive fla1;
delete from t1;
--48 rows deleted.
commit;
select count(*) from t1;
--0
-- select to 5 min ago
select count(*) from t1 as of timestamp(sysdate-5/1140);
--48
drop table t1;
--ORA-55610: Invalid DDL statement on history-tracked table

--connect system@orclpdb;
drop user FBDAUSER cascade;
--ORA-00604: error occurred at recursive SQL level 1
--ORA-55622: DML, ALTER and CREATE UNIQUE INDEX operations are not allowed on
--table "FBDAUSER"."SYS_FBA_TCRV_73261"

drop tablespace fda including contents and datafiles;
--ORA-55641: Cannot drop tablespace used by Flashback Data Archive

select * from dba_flashback_archive;
select * from dba_flashback_archive_ts;
select * from dba_flashback_archive_tables;

alter table FBDAUSER.t1 no flashback archive;
select * from dba_flashback_archive_tables;
--status=DISABLED
drop flashback archive fla1;
--all 3 are empty
select * from dba_flashback_archive;
select * from dba_flashback_archive_ts;
select * from dba_flashback_archive_tables;
-- connect fbdauser@orclpdb;
drop table t1;
-- no error
--conn system@orclpdb;
drop user FBDAUSER cascade;
-- no error
drop tablespace fda including contents and datafiles;
-- no error
select * from dba_data_files;
-- tablespace and files are gone
----------------------------------------
--to create, alter, drop archive, modify retention and purge
grant flashback archive administer to u1;
--to add tables to archive
grant flashback archive on a1 to u1;
--change retention
alter flashback archive a1 modify retention 7 year;
-- remove some data in archive
alter flashback a1 purge before timestamp to_timestamp('01-01-2015','dd-mm-yyyy');
