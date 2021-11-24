select parallel from v$instance;
--NO (if no RAC used)

select protection_level from v$database;
--MAXIMUM PERFORMANCE (dataguard)
--UNPROTECTED (no dataguard)

select * from dba_streams_administrator;
--no rows, if no streams
