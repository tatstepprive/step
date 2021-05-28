column file# format a50
set linesize 300;
select file#, online_status from v$recover_file;
