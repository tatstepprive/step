--Enable Archive log (offline operation)
--default disabled
--steps
--shutdown immediate;
--startup mount;
alter database archivelog;
--alter database open;
--archive log list;
--force log switch and archive
alter system archive log current;
--check 
select name, is_recovery_dest_file from v$archived_log;
