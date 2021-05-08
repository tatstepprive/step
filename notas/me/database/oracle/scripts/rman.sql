select * from v$process;
select * from v$block_change_tracking;
--1 row column status=disabled
select * from v$backup_files;
--only fily_type=ARCHIVE LOG
select * from v$backup_set;
--empty
select * from v$backup_piece;
--empty
select * from  v$backup_redolog;
--empty
select * from  v$backup_spfile;
--empty
select * from  v$backup_datafile;
--empty
select * from v$backup_device;
--1 row device_type=SBT_TAPE 
select * from v$rman_configuration;
--empty
-----------------------------
--After backup changes in views
select * from v$backup_files;
-- file_type=ARCHIVE LOG with backup_type=copy. Now file_type=(archive log, datafile, piece, spfile, control file) backup_type=copy, backup set
select * from v$backup_set;
--8 rows
select * from  v$backup_spfile;
--1 row
select * from  v$backup_datafile;
--27 rows
--fra is now from 0 to 3.5GB 
------------------------------
--Change tracking to make rman faster
--Before
select * from v$block_change_tracking;
--1 row status=DISABLED
select program from v$process where program like '%CTWR%';
--empty

--Enable change tracking file
alter database enable block change tracking using file '/u01/app/oracle/oradata/ORCL/change_tracking.dbf';
--Check
select * from v$block_change_tracking;
--1 row status=ENABLED filename='/u01/app/oracle/oradata/ORCL/change_tracking.dbf';
select program from v$process where program like '%CTWR%';
--1 row program=oracle@oracledb (CTWR)
------------------------------------
--After second backup level 0 via rman fra 3.5GB to 7G
--After second backup level 1 still 7G (because no changes)


