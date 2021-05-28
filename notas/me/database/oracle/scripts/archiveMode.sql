--Activate archivelog mode
-- create archive dirs on host mkdir /u01/app/oracle/oradata/ORCL/archive1 /u01/app/oracle/oradata/ORCL/archive2
-- sqlplus / as sysdba
sql> select log_mode from v$database;
--output log_mode=NOARCHIVELOG
sql> select archiver from v$instance;
--output archiver=stopped
sql> alter system set log_archive_dest_1='LOCATION=/u01/app/oracle/oradata/ORCL/archive1';
sql> alter system set log_archive_dest_2='LOCATION=/u01/app/oracle/oradata/ORCL/archive2';
sql> alter system set log_archive_format='arch_%d_%t_r%_s%.log' scope=spfile;
sql> shutdown immediate;
sql> startup mount;
sql> alter database archivelog;
sql> alter database open;
sql>show parameter log_archive_format;
sql>show parameter spfile;
sql> select log_mode from v$database;
--output log_mode=ARCHIVELOG
sql> select archiver from v$instance;
--output archiver=started
sql> alter system switch logfile;
sql> select name from v$archived_log;


