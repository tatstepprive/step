--Show OMF (Oracle Managed Files) is enabled, so all or some params are set
--Dir for datafiles 
select * from v$parameter where name ='db_create_file_dest';
--Dirs (1-5) for redo logs
select * from v$parameter where name like 'db_create_online_log_dest_%';
--Dir for archive log files and Rman backups
select * from v$parameter where name ='db_recovery_file_dest';
--OMF defaults:
--file name: o1_mf_mytbsname_8RandomChars.dbf 
--file size: 100MB
--autoextend on
--Plus points:
--1 create tbs with mininum syntax: create tablespace t1;
--2 full db import will work even without tablespaces, they will be auto created
