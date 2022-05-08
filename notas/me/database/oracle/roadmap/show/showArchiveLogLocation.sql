--Show archive log location
archive log list
--see Archive Destination USE_RECOVERY_FILE_DEST
show parameter RECOVERY_FILE_DEST;
--value=<path>

--The archive destination can be set with parameter log_archive_dest_n where n=number
show parameter log_archive_dest;
--the same
show parameter dest_1;

--show archive dest
select * from v$archive_dest;

