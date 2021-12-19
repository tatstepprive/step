--show fast/flash recovery area
--show fra location (if not set, goes to $ORACLE_HOME/dbs)
-- parameter: db_recovery_file_dest for location
-- parameter: db_recovery_file_dest_size for size
select * from v$parameter where name like 'db_recovery%';
--show fra location
select * from v$recovery_file_dest;
--show fra usage
select * from v$recovery_area_usage;
