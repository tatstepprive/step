--show location trace log files 
select value from v$diag_info where NAME='Diag Trace';
