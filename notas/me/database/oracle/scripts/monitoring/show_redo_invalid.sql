column name format a50
set linesize 300;
select group#, status from v$logfile where status='INVALID';
