column owner format a35
column object_name format a50
column object_type format a20
set linesize 200;
select owner, object_name, object_type, status from dba_objects where status='INVALID';
