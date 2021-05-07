show parameter db_recovery;
--output 
--db_recovery_file_dest      string            
--db_recovery_file_dest_size big integer 0
-- FRA flash recovery are is not set by default

select * from v$controlfile;
--IS_RECOVERY_DEST_FILE=NO for each row
select * from v$logfile;
--IS_RECOVERY_DEST_FILE=NO for each row
select * from v$archived_log;
--IS_RECOVERY_DEST_FILE=NO for each row
select * from v$backup_piece;
--empty, no rows
select * from v$recovery_area_usage;
--empty, no rows
-------------------------
--set fra=fast recovery area
ALTER SYSTEM SET DB_RECOVERY_FILE_DEST_SIZE = 20G SCOPE=BOTH ;
ALTER SYSTEM SET DB_RECOVERY_FILE_DEST = '/oracle/ora01/ORCL/fast_recovery_area' SCOPE=BOTH;
select * from v$flash_recovery_area_usage;
-- contains rows (=8)
