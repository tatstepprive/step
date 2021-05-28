column owner format a35
column index_name format a50
set linesize 200;
select owner,index_name, status from dba_indexes where status='UNUSABLE';
