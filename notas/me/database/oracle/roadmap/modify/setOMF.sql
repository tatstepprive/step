--Set OMF (Oracle Managed Files) enabled, by setting all or some params
--Dir for datafiles 
alter system set db_create_file_dest='/home/oradata';
--Dirs (1-5) for redo logs
alter system set db_create_online_log_dest_1='/home/redo';
--Dir for archive log files and Rman backups
alter system set db_recovery_file_dest='/home/oracle/ora01/ORCL/fast_recovery_area';
--OMF defaults for data files:
--file name: o1_mf_mytbsname_8RandomChars.dbf 
--file size: 100MB
--autoextend on
--Plus points:
--1 create tbs with mininum syntax: create tablespace t1;
--2 full db import will work even without tablespaces, they will be auto created
